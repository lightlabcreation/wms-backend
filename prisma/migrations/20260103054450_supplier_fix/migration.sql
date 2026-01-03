-- AlterTable
ALTER TABLE `supplier` MODIFY `paymentTerms` ENUM('COD', 'NET_7', 'NET_15', 'NET_30', 'NET_60') NOT NULL DEFAULT 'COD';
