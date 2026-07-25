import { IsNotEmpty, IsOptional, IsString, MaxLength} from 'class-validator';

export class CreateCampaignDto {
    @IsNotEmpty()
    @IsString()
    @MaxLength(100)
    name: string;

    @IsNotEmpty()
    @IsString()
    @MaxLength(100)
    rpgSystem: string;

    @IsString()
    @MaxLength(5000)
    description: string;

    @IsOptional()
    @IsString()
    @MaxLength(500)
    coverImageUrl?: string;

    @IsOptional()
    IsPublic?: boolean;
}