/*
  Warnings:

  - The values [DIRECT,CUSTOM] on the enum `SalesChannel_type` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterTable
ALTER TABLE `saleschannel` MODIFY `type` ENUM('AMAZON_FBA', 'AMAZON_FBM', 'SHOPIFY', 'EBAY', 'TIKTOK', 'WHOLESALE') NOT NULL;
