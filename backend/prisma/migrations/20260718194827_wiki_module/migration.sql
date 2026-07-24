/*
  Warnings:

  - A unique constraint covering the columns `[username]` on the table `User` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateEnum
CREATE TYPE "CampaignMemberStatus" AS ENUM ('ACTIVE', 'LEFT', 'REMOVED');

-- CreateEnum
CREATE TYPE "CampaignRole" AS ENUM ('OWNER', 'GAME_MASTER', 'PLAYER', 'OBSERVER');

-- CreateEnum
CREATE TYPE "CharacterStatus" AS ENUM ('ALIVE', 'DEAD', 'RETIRED', 'MISSING');

-- CreateEnum
CREATE TYPE "ApprovalStatus" AS ENUM ('APPROVED', 'REJECTED', 'PENDING');

-- CreateEnum
CREATE TYPE "WikiPageType" AS ENUM ('NPC', 'CITY', 'LOCATION', 'ITEM', 'ORGANIZATION', 'RELIGION_GROUP', 'FACTION', 'KINGDOM', 'EVENT', 'DEITY', 'CUSTOM');

-- CreateEnum
CREATE TYPE "WikiRelationType" AS ENUM ('LOCATED_IN', 'MEMBER_OF', 'OWNS', 'LEADS', 'PARTICIPATED_IN', 'WORSHIPS', 'PARENT_OF', 'ALLY_OF', 'ENEMY_OF', 'RELATED_TO', 'CUSTOM');

-- CreateEnum
CREATE TYPE "WikiAuthorRole" AS ENUM ('CREATOR', 'CONTRIBUTOR', 'REVIEWER');

-- CreateTable
CREATE TABLE "Campaign" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "rpgSystem" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "coverImageUrl" TEXT,
    "isPublic" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Campaign_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CampaignMember" (
    "id" TEXT NOT NULL,
    "role" "CampaignRole" NOT NULL,
    "status" "CampaignMemberStatus" NOT NULL DEFAULT 'ACTIVE',
    "userId" TEXT NOT NULL,
    "campaignId" TEXT NOT NULL,
    "joinedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "leftAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "CampaignMember_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PlayerCharacter" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "title" TEXT,
    "race" TEXT NOT NULL,
    "characterClass" TEXT NOT NULL,
    "history" TEXT,
    "appearance" TEXT,
    "personality" TEXT,
    "portraitUrl" TEXT,
    "status" "CharacterStatus" NOT NULL DEFAULT 'ALIVE',
    "approvalStatus" "ApprovalStatus" NOT NULL DEFAULT 'PENDING',
    "diedAt" TIMESTAMP(3),
    "approvedAt" TIMESTAMP(3),
    "approvedByMemberId" TEXT,
    "campaignId" TEXT NOT NULL,
    "campaignMemberId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PlayerCharacter_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WikiPage" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "summary" TEXT,
    "content" TEXT NOT NULL,
    "type" "WikiPageType" NOT NULL DEFAULT 'CUSTOM',
    "approvalStatus" "ApprovalStatus" NOT NULL DEFAULT 'PENDING',
    "approvedAt" TIMESTAMP(3),
    "approvedByMemberId" TEXT,
    "campaignId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "WikiPage_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WikiPageRelation" (
    "id" TEXT NOT NULL,
    "pageType" "WikiPageType" NOT NULL DEFAULT 'CUSTOM',
    "label" TEXT,
    "sourcePageId" TEXT NOT NULL,
    "targetPageId" TEXT NOT NULL,
    "createdByMemberId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "WikiPageRelation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WikiPageAuthor" (
    "id" TEXT NOT NULL,
    "role" "WikiAuthorRole" NOT NULL DEFAULT 'CONTRIBUTOR',
    "wikiPageId" TEXT NOT NULL,
    "campaignMemberId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "WikiPageAuthor_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "CampaignMember_userId_campaignId_key" ON "CampaignMember"("userId", "campaignId");

-- CreateIndex
CREATE UNIQUE INDEX "WikiPage_campaignId_slug_key" ON "WikiPage"("campaignId", "slug");

-- CreateIndex
CREATE UNIQUE INDEX "WikiPageAuthor_wikiPageId_campaignMemberId_key" ON "WikiPageAuthor"("wikiPageId", "campaignMemberId");

-- CreateIndex
CREATE UNIQUE INDEX "User_username_key" ON "User"("username");

-- AddForeignKey
ALTER TABLE "CampaignMember" ADD CONSTRAINT "CampaignMember_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CampaignMember" ADD CONSTRAINT "CampaignMember_campaignId_fkey" FOREIGN KEY ("campaignId") REFERENCES "Campaign"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PlayerCharacter" ADD CONSTRAINT "PlayerCharacter_approvedByMemberId_fkey" FOREIGN KEY ("approvedByMemberId") REFERENCES "CampaignMember"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PlayerCharacter" ADD CONSTRAINT "PlayerCharacter_campaignId_fkey" FOREIGN KEY ("campaignId") REFERENCES "Campaign"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PlayerCharacter" ADD CONSTRAINT "PlayerCharacter_campaignMemberId_fkey" FOREIGN KEY ("campaignMemberId") REFERENCES "CampaignMember"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WikiPage" ADD CONSTRAINT "WikiPage_campaignId_fkey" FOREIGN KEY ("campaignId") REFERENCES "Campaign"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WikiPage" ADD CONSTRAINT "WikiPage_approvedByMemberId_fkey" FOREIGN KEY ("approvedByMemberId") REFERENCES "CampaignMember"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WikiPageRelation" ADD CONSTRAINT "WikiPageRelation_sourcePageId_fkey" FOREIGN KEY ("sourcePageId") REFERENCES "WikiPage"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WikiPageRelation" ADD CONSTRAINT "WikiPageRelation_targetPageId_fkey" FOREIGN KEY ("targetPageId") REFERENCES "WikiPage"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WikiPageRelation" ADD CONSTRAINT "WikiPageRelation_createdByMemberId_fkey" FOREIGN KEY ("createdByMemberId") REFERENCES "CampaignMember"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WikiPageAuthor" ADD CONSTRAINT "WikiPageAuthor_wikiPageId_fkey" FOREIGN KEY ("wikiPageId") REFERENCES "WikiPage"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "WikiPageAuthor" ADD CONSTRAINT "WikiPageAuthor_campaignMemberId_fkey" FOREIGN KEY ("campaignMemberId") REFERENCES "CampaignMember"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
