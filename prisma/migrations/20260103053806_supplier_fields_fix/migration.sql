-- AlterTable
ALTER TABLE `supplier` ADD COLUMN `paymentTerms` ENUM('COD', 'NET_7', 'NET_15', 'NET_30') NOT NULL DEFAULT 'COD';
