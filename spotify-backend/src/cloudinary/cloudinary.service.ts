import { Injectable } from "@nestjs/common";
import { UploadApiResponse } from "cloudinary";
import { cloudinary } from "./cloudinary.provider";
import { Readable } from "node:stream";


@Injectable()
export class CloudinaryService {
    async uploadFile(buffer: Buffer, folder: string, resourceType: 'image' | 'video' | 'raw'): Promise<UploadApiResponse> {
        return new Promise((resolve, reject) => {
            const stream = cloudinary.uploader.upload_stream(
                { folder, resource_type: resourceType },
                (error, result) => {
                    if (error) return reject(error);
                    if (!result) return reject(new Error("No result from Cloudinary"));
                    resolve(result);
                },
            );

            const readable = new Readable();
            readable.push(buffer);
            readable.push(null);
            readable.pipe(stream);
        });
    }
}
