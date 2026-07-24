import { Module } from '@nestjs/common';
import { CampaignModule } from './campaign/campaign.module';
import { PrismaModule } from './prisma/prisma.module';

@Module({
  imports: [PrismaModule, CampaignModule],
})
export class AppModule {}
