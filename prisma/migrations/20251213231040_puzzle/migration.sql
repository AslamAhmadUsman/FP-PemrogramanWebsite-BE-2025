/*
  Warnings:

  - You are about to drop the `Puzzle` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `PuzzleSession` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE IF EXISTS "PuzzleSession" DROP CONSTRAINT IF EXISTS "PuzzleSession_puzzleId_fkey";

-- DropTable
DROP TABLE IF EXISTS "Puzzle";

-- DropTable
DROP TABLE IF EXISTS "PuzzleSession";

-- CreateTable
CREATE TABLE IF NOT EXISTS "Leaderboard" (
    "id" TEXT NOT NULL,
    "user_id" TEXT,
    "game_id" TEXT NOT NULL,
    "score" INTEGER NOT NULL,
    "difficulty" TEXT,
    "time_taken" INTEGER,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Leaderboard_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX IF NOT EXISTS "Leaderboard_game_id_score_idx" ON "Leaderboard"("game_id", "score");

-- CreateIndex
CREATE INDEX IF NOT EXISTS "Leaderboard_user_id_idx" ON "Leaderboard"("user_id");

-- AddForeignKey (only if not exists)
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'Leaderboard_user_id_fkey') THEN
        ALTER TABLE "Leaderboard" ADD CONSTRAINT "Leaderboard_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "Users"("id") ON DELETE SET NULL ON UPDATE CASCADE;
    END IF;
END $$;

-- AddForeignKey (only if not exists)
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'Leaderboard_game_id_fkey') THEN
        ALTER TABLE "Leaderboard" ADD CONSTRAINT "Leaderboard_game_id_fkey" FOREIGN KEY ("game_id") REFERENCES "Games"("id") ON DELETE CASCADE ON UPDATE CASCADE;
    END IF;
END $$;

