import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateCampaignDto } from './dto/create-campaign.dto';

@Injectable()
export class CampaignService {

    constructor(private readonly prisma: PrismaService) {}

    async findAll() {
        return await this.prisma.campaign.findMany();
    }

    async create(createCampaignDto: CreateCampaignDto) {
        return await this.prisma.campaign.create({
            data: createCampaignDto,
        });
    }
}
