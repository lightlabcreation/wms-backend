-- CreateTable
CREATE TABLE `User` (
    `id` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `password` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `role` ENUM('SUPER_ADMIN', 'COMPANY_ADMIN', 'WAREHOUSE_MANAGER', 'INVENTORY_MANAGER', 'PICKER', 'VIEWER', 'ADMIN', 'USER', 'PACKER', 'MANAGER') NOT NULL DEFAULT 'USER',
    `companyId` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `User_email_key`(`email`),
    INDEX `User_companyId_idx`(`companyId`),
    INDEX `User_email_idx`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Company` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `code` VARCHAR(191) NOT NULL,
    `description` VARCHAR(191) NULL,
    `address` VARCHAR(191) NULL,
    `phone` VARCHAR(191) NULL,
    `email` VARCHAR(191) NULL,
    `currency` VARCHAR(191) NOT NULL DEFAULT 'USD',
    `timezone` VARCHAR(191) NOT NULL DEFAULT 'UTC',
    `dateFormat` VARCHAR(191) NOT NULL DEFAULT 'YYYY-MM-DD',
    `logo` VARCHAR(191) NULL,
    `emailNotifications` BOOLEAN NOT NULL DEFAULT true,
    `lowStockAlerts` BOOLEAN NOT NULL DEFAULT true,
    `orderConfirmations` BOOLEAN NOT NULL DEFAULT true,
    `defaultWarehouse` VARCHAR(191) NULL,
    `autoReorderEnabled` BOOLEAN NOT NULL DEFAULT false,
    `batchTrackingEnabled` BOOLEAN NOT NULL DEFAULT true,
    `expiryTrackingEnabled` BOOLEAN NOT NULL DEFAULT true,
    `lowStockThreshold` INTEGER NOT NULL DEFAULT 10,
    `defaultTaxRate` DOUBLE NOT NULL DEFAULT 0,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `Company_code_key`(`code`),
    INDEX `Company_code_idx`(`code`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Warehouse` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `code` VARCHAR(191) NOT NULL,
    `type` ENUM('MAIN', 'PREP', 'RETURNS', 'OVERFLOW') NOT NULL DEFAULT 'MAIN',
    `companyId` VARCHAR(191) NOT NULL,
    `address` VARCHAR(191) NULL,
    `phone` VARCHAR(191) NULL,
    `capacity` INTEGER NULL,
    `status` ENUM('ACTIVE', 'INACTIVE', 'MAINTENANCE') NOT NULL DEFAULT 'ACTIVE',
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `Warehouse_code_key`(`code`),
    INDEX `Warehouse_companyId_idx`(`companyId`),
    INDEX `Warehouse_code_idx`(`code`),
    INDEX `Warehouse_type_idx`(`type`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Zone` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `code` VARCHAR(191) NOT NULL,
    `warehouseId` VARCHAR(191) NOT NULL,
    `zoneType` ENUM('STANDARD', 'COLD', 'FROZEN', 'HAZMAT', 'QUARANTINE') NOT NULL DEFAULT 'STANDARD',
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    INDEX `Zone_warehouseId_idx`(`warehouseId`),
    UNIQUE INDEX `Zone_warehouseId_code_key`(`warehouseId`, `code`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Location` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `code` VARCHAR(191) NOT NULL,
    `warehouseId` VARCHAR(191) NOT NULL,
    `zoneId` VARCHAR(191) NULL,
    `aisle` VARCHAR(191) NULL,
    `rack` VARCHAR(191) NULL,
    `shelf` VARCHAR(191) NULL,
    `bin` VARCHAR(191) NULL,
    `locationType` ENUM('PICK', 'BULK', 'BULK_LW') NOT NULL DEFAULT 'PICK',
    `weightLimit` DOUBLE NULL,
    `currentWeight` DOUBLE NOT NULL DEFAULT 0,
    `pickSequence` INTEGER NULL,
    `isHeatSensitive` BOOLEAN NOT NULL DEFAULT false,
    `isPrimaryPick` BOOLEAN NOT NULL DEFAULT false,
    `minStockLevel` INTEGER NULL,
    `maxStockLevel` INTEGER NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    INDEX `Location_warehouseId_idx`(`warehouseId`),
    INDEX `Location_zoneId_idx`(`zoneId`),
    INDEX `Location_locationType_idx`(`locationType`),
    INDEX `Location_pickSequence_idx`(`pickSequence`),
    INDEX `Location_isPrimaryPick_idx`(`isPrimaryPick`),
    UNIQUE INDEX `Location_warehouseId_code_key`(`warehouseId`, `code`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Brand` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `code` VARCHAR(191) NOT NULL,
    `description` VARCHAR(191) NULL,
    `companyId` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `Brand_code_key`(`code`),
    INDEX `Brand_companyId_idx`(`companyId`),
    INDEX `Brand_code_idx`(`code`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Product` (
    `id` VARCHAR(191) NOT NULL,
    `sku` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `description` VARCHAR(191) NULL,
    `barcode` VARCHAR(191) NULL,
    `companyId` VARCHAR(191) NOT NULL,
    `brandId` VARCHAR(191) NULL,
    `type` ENUM('SIMPLE', 'VARIANT', 'BUNDLE') NOT NULL DEFAULT 'SIMPLE',
    `status` ENUM('ACTIVE', 'INACTIVE', 'DISCONTINUED') NOT NULL DEFAULT 'ACTIVE',
    `length` DOUBLE NULL,
    `width` DOUBLE NULL,
    `height` DOUBLE NULL,
    `weight` DOUBLE NULL,
    `dimensionUnit` VARCHAR(191) NULL DEFAULT 'cm',
    `weightUnit` VARCHAR(191) NULL DEFAULT 'kg',
    `costPrice` DOUBLE NULL,
    `sellingPrice` DOUBLE NULL,
    `currency` VARCHAR(191) NOT NULL DEFAULT 'GBP',
    `vatRate` DOUBLE NOT NULL DEFAULT 20.0,
    `vatCode` VARCHAR(191) NULL,
    `isHeatSensitive` BOOLEAN NOT NULL DEFAULT false,
    `primarySupplierId` VARCHAR(191) NULL,
    `cartonSizes` INTEGER NULL,
    `ffdSku` VARCHAR(191) NULL,
    `ffdSaleSku` VARCHAR(191) NULL,
    `wsSku` VARCHAR(191) NULL,
    `amzSku` VARCHAR(191) NULL,
    `amzSkuBb` VARCHAR(191) NULL,
    `amzSkuM` VARCHAR(191) NULL,
    `amzSkuEu` VARCHAR(191) NULL,
    `onBuySku` VARCHAR(191) NULL,
    `isPerishable` BOOLEAN NOT NULL DEFAULT false,
    `requiresBatch` BOOLEAN NOT NULL DEFAULT false,
    `requiresSerial` BOOLEAN NOT NULL DEFAULT false,
    `shelfLifeDays` INTEGER NULL,
    `images` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `Product_sku_key`(`sku`),
    INDEX `Product_companyId_idx`(`companyId`),
    INDEX `Product_brandId_idx`(`brandId`),
    INDEX `Product_sku_idx`(`sku`),
    INDEX `Product_type_idx`(`type`),
    INDEX `Product_status_idx`(`status`),
    INDEX `Product_isHeatSensitive_idx`(`isHeatSensitive`),
    INDEX `Product_primarySupplierId_idx`(`primarySupplierId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `BundleItem` (
    `id` VARCHAR(191) NOT NULL,
    `parentId` VARCHAR(191) NOT NULL,
    `childId` VARCHAR(191) NOT NULL,
    `quantity` INTEGER NOT NULL,
    `componentCost` DOUBLE NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `BundleItem_parentId_idx`(`parentId`),
    INDEX `BundleItem_childId_idx`(`childId`),
    UNIQUE INDEX `BundleItem_parentId_childId_key`(`parentId`, `childId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Inventory` (
    `id` VARCHAR(191) NOT NULL,
    `productId` VARCHAR(191) NOT NULL,
    `warehouseId` VARCHAR(191) NOT NULL,
    `locationId` VARCHAR(191) NULL,
    `lotNumber` VARCHAR(191) NULL,
    `batchNumber` VARCHAR(191) NULL,
    `serialNumber` VARCHAR(191) NULL,
    `batchBarcode` VARCHAR(191) NULL,
    `bestBeforeDate` DATETIME(3) NULL,
    `receivedDate` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `quantity` INTEGER NOT NULL DEFAULT 0,
    `availableQuantity` INTEGER NOT NULL DEFAULT 0,
    `reservedQuantity` INTEGER NOT NULL DEFAULT 0,
    `status` ENUM('AVAILABLE', 'RESERVED', 'QUARANTINE', 'DAMAGED', 'EXPIRED') NOT NULL DEFAULT 'AVAILABLE',
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    INDEX `Inventory_productId_idx`(`productId`),
    INDEX `Inventory_warehouseId_idx`(`warehouseId`),
    INDEX `Inventory_locationId_idx`(`locationId`),
    INDEX `Inventory_bestBeforeDate_idx`(`bestBeforeDate`),
    INDEX `Inventory_lotNumber_idx`(`lotNumber`),
    INDEX `Inventory_batchBarcode_idx`(`batchBarcode`),
    UNIQUE INDEX `Inventory_productId_warehouseId_locationId_lotNumber_key`(`productId`, `warehouseId`, `locationId`, `lotNumber`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `StockAdjustment` (
    `id` VARCHAR(191) NOT NULL,
    `type` ENUM('INCREASE', 'DECREASE', 'DAMAGE', 'LOSS', 'FOUND', 'RECOUNT') NOT NULL,
    `status` ENUM('PENDING', 'APPROVED', 'COMPLETED', 'REJECTED') NOT NULL DEFAULT 'PENDING',
    `warehouseId` VARCHAR(191) NOT NULL,
    `reason` VARCHAR(191) NOT NULL,
    `notes` VARCHAR(191) NULL,
    `requestedBy` VARCHAR(191) NOT NULL,
    `approvedBy` VARCHAR(191) NULL,
    `completedAt` DATETIME(3) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    INDEX `StockAdjustment_warehouseId_idx`(`warehouseId`),
    INDEX `StockAdjustment_status_idx`(`status`),
    INDEX `StockAdjustment_createdAt_idx`(`createdAt`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `StockAdjustmentItem` (
    `id` VARCHAR(191) NOT NULL,
    `adjustmentId` VARCHAR(191) NOT NULL,
    `productId` VARCHAR(191) NOT NULL,
    `locationId` VARCHAR(191) NULL,
    `batchNumber` VARCHAR(191) NULL,
    `quantity` INTEGER NOT NULL,
    `unitCost` DOUBLE NOT NULL DEFAULT 0,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `StockAdjustmentItem_adjustmentId_idx`(`adjustmentId`),
    INDEX `StockAdjustmentItem_productId_idx`(`productId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `InventoryMovement` (
    `id` VARCHAR(191) NOT NULL,
    `type` ENUM('RECEIVE', 'PICK', 'TRANSFER', 'ADJUST', 'RETURN', 'CYCLE_COUNT', 'SHIPMENT', 'DAMAGE', 'LOSS') NOT NULL,
    `productId` VARCHAR(191) NOT NULL,
    `batchId` VARCHAR(191) NULL,
    `fromLocationId` VARCHAR(191) NULL,
    `toLocationId` VARCHAR(191) NULL,
    `quantity` DOUBLE NOT NULL,
    `reason` VARCHAR(191) NULL,
    `notes` VARCHAR(191) NULL,
    `userId` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `InventoryMovement_productId_idx`(`productId`),
    INDEX `InventoryMovement_type_idx`(`type`),
    INDEX `InventoryMovement_userId_idx`(`userId`),
    INDEX `InventoryMovement_createdAt_idx`(`createdAt`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `CycleCount` (
    `id` VARCHAR(191) NOT NULL,
    `warehouseId` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `status` ENUM('SCHEDULED', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED') NOT NULL DEFAULT 'SCHEDULED',
    `type` ENUM('FULL', 'PARTIAL', 'SPOT') NOT NULL DEFAULT 'FULL',
    `scheduledDate` DATETIME(3) NOT NULL,
    `completedDate` DATETIME(3) NULL,
    `locations` JSON NULL,
    `variance` JSON NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    INDEX `CycleCount_warehouseId_idx`(`warehouseId`),
    INDEX `CycleCount_status_idx`(`status`),
    INDEX `CycleCount_scheduledDate_idx`(`scheduledDate`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `CycleCountItem` (
    `id` VARCHAR(191) NOT NULL,
    `cycleCountId` VARCHAR(191) NOT NULL,
    `productId` VARCHAR(191) NOT NULL,
    `expectedQuantity` INTEGER NOT NULL DEFAULT 0,
    `actualQuantity` INTEGER NULL,
    `variance` INTEGER NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `CycleCountItem_cycleCountId_idx`(`cycleCountId`),
    INDEX `CycleCountItem_productId_idx`(`productId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Customer` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `code` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NULL,
    `phone` VARCHAR(191) NULL,
    `address` VARCHAR(191) NULL,
    `companyId` VARCHAR(191) NOT NULL,
    `customerType` ENUM('B2C', 'B2B') NOT NULL DEFAULT 'B2C',
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `Customer_code_key`(`code`),
    INDEX `Customer_companyId_idx`(`companyId`),
    INDEX `Customer_code_idx`(`code`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `SalesOrder` (
    `id` VARCHAR(191) NOT NULL,
    `orderNumber` VARCHAR(191) NOT NULL,
    `customerId` VARCHAR(191) NOT NULL,
    `isWholesale` BOOLEAN NOT NULL DEFAULT false,
    `salesChannel` VARCHAR(191) NULL,
    `externalOrderId` VARCHAR(191) NULL,
    `status` ENUM('PENDING', 'CONFIRMED', 'ALLOCATED', 'PICKING', 'PACKING', 'SHIPPED', 'DELIVERED', 'CANCELLED') NOT NULL DEFAULT 'PENDING',
    `priority` ENUM('LOW', 'MEDIUM', 'HIGH', 'URGENT') NOT NULL DEFAULT 'MEDIUM',
    `subtotal` DOUBLE NOT NULL DEFAULT 0,
    `taxAmount` DOUBLE NOT NULL DEFAULT 0,
    `shippingCost` DOUBLE NOT NULL DEFAULT 0,
    `discountAmount` DOUBLE NOT NULL DEFAULT 0,
    `totalAmount` DOUBLE NOT NULL DEFAULT 0,
    `shippingAddress` VARCHAR(191) NULL,
    `shippingMethod` VARCHAR(191) NULL,
    `trackingNumber` VARCHAR(191) NULL,
    `carrier` VARCHAR(191) NULL,
    `shippingNotes` VARCHAR(191) NULL,
    `notes` VARCHAR(191) NULL,
    `orderDate` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `requiredDate` DATETIME(3) NULL,
    `shippedDate` DATETIME(3) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `SalesOrder_orderNumber_key`(`orderNumber`),
    INDEX `SalesOrder_orderNumber_idx`(`orderNumber`),
    INDEX `SalesOrder_customerId_idx`(`customerId`),
    INDEX `SalesOrder_status_idx`(`status`),
    INDEX `SalesOrder_isWholesale_idx`(`isWholesale`),
    INDEX `SalesOrder_salesChannel_idx`(`salesChannel`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `SalesOrderItem` (
    `id` VARCHAR(191) NOT NULL,
    `orderId` VARCHAR(191) NOT NULL,
    `productId` VARCHAR(191) NOT NULL,
    `quantity` INTEGER NOT NULL,
    `unitPrice` DOUBLE NOT NULL,
    `discount` DOUBLE NOT NULL DEFAULT 0,
    `tax` DOUBLE NOT NULL DEFAULT 0,
    `totalPrice` DOUBLE NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `SalesOrderItem_orderId_idx`(`orderId`),
    INDEX `SalesOrderItem_productId_idx`(`productId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `PickList` (
    `id` VARCHAR(191) NOT NULL,
    `pickListNumber` VARCHAR(191) NOT NULL,
    `type` ENUM('SINGLE', 'BATCH', 'WAVE', 'ZONE') NOT NULL DEFAULT 'SINGLE',
    `orderId` VARCHAR(191) NULL,
    `assignedUserId` VARCHAR(191) NULL,
    `status` ENUM('PENDING', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED') NOT NULL DEFAULT 'PENDING',
    `priority` ENUM('LOW', 'MEDIUM', 'HIGH', 'URGENT') NOT NULL DEFAULT 'MEDIUM',
    `enforceSingleBBDate` BOOLEAN NOT NULL DEFAULT false,
    `startedAt` DATETIME(3) NULL,
    `completedAt` DATETIME(3) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `PickList_pickListNumber_key`(`pickListNumber`),
    INDEX `PickList_pickListNumber_idx`(`pickListNumber`),
    INDEX `PickList_orderId_idx`(`orderId`),
    INDEX `PickList_assignedUserId_idx`(`assignedUserId`),
    INDEX `PickList_status_idx`(`status`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `PickItem` (
    `id` VARCHAR(191) NOT NULL,
    `pickListId` VARCHAR(191) NOT NULL,
    `productId` VARCHAR(191) NOT NULL,
    `locationId` VARCHAR(191) NULL,
    `selectedBBDate` DATETIME(3) NULL,
    `lotNumber` VARCHAR(191) NULL,
    `quantityRequired` INTEGER NOT NULL,
    `quantityPicked` INTEGER NOT NULL DEFAULT 0,
    `status` ENUM('PENDING', 'PICKED', 'SHORT_PICKED', 'SKIPPED') NOT NULL DEFAULT 'PENDING',
    `sequenceNumber` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    INDEX `PickItem_pickListId_idx`(`pickListId`),
    INDEX `PickItem_productId_idx`(`productId`),
    INDEX `PickItem_locationId_idx`(`locationId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ReplenishmentConfig` (
    `id` VARCHAR(191) NOT NULL,
    `productId` VARCHAR(191) NOT NULL,
    `minStockLevel` INTEGER NOT NULL,
    `maxStockLevel` INTEGER NOT NULL,
    `reorderPoint` INTEGER NOT NULL,
    `reorderQuantity` INTEGER NOT NULL,
    `autoCreateTasks` BOOLEAN NOT NULL DEFAULT true,
    `enabled` BOOLEAN NOT NULL DEFAULT true,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `ReplenishmentConfig_productId_key`(`productId`),
    INDEX `ReplenishmentConfig_productId_idx`(`productId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ReplenishmentTask` (
    `id` VARCHAR(191) NOT NULL,
    `taskNumber` VARCHAR(191) NOT NULL,
    `productId` VARCHAR(191) NOT NULL,
    `fromLocation` VARCHAR(191) NULL,
    `toLocation` VARCHAR(191) NULL,
    `quantityNeeded` INTEGER NOT NULL,
    `quantityMoved` INTEGER NOT NULL DEFAULT 0,
    `status` ENUM('PENDING', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED') NOT NULL DEFAULT 'PENDING',
    `priority` ENUM('LOW', 'MEDIUM', 'HIGH', 'URGENT') NOT NULL DEFAULT 'MEDIUM',
    `assignedUserId` VARCHAR(191) NULL,
    `notes` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `completedAt` DATETIME(3) NULL,
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `ReplenishmentTask_taskNumber_key`(`taskNumber`),
    INDEX `ReplenishmentTask_taskNumber_idx`(`taskNumber`),
    INDEX `ReplenishmentTask_productId_idx`(`productId`),
    INDEX `ReplenishmentTask_status_idx`(`status`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Transfer` (
    `id` VARCHAR(191) NOT NULL,
    `transferNumber` VARCHAR(191) NOT NULL,
    `type` ENUM('WAREHOUSE', 'FBA_PREP', 'FBA_SHIPMENT') NOT NULL DEFAULT 'WAREHOUSE',
    `fromWarehouseId` VARCHAR(191) NOT NULL,
    `toWarehouseId` VARCHAR(191) NOT NULL,
    `status` ENUM('PENDING', 'IN_TRANSIT', 'RECEIVING', 'COMPLETED', 'CANCELLED') NOT NULL DEFAULT 'PENDING',
    `fbaShipmentId` VARCHAR(191) NULL,
    `fbaDestination` VARCHAR(191) NULL,
    `shipmentBuilt` BOOLEAN NOT NULL DEFAULT false,
    `notes` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `shippedAt` DATETIME(3) NULL,
    `receivedAt` DATETIME(3) NULL,
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `Transfer_transferNumber_key`(`transferNumber`),
    INDEX `Transfer_transferNumber_idx`(`transferNumber`),
    INDEX `Transfer_fromWarehouseId_idx`(`fromWarehouseId`),
    INDEX `Transfer_toWarehouseId_idx`(`toWarehouseId`),
    INDEX `Transfer_type_idx`(`type`),
    INDEX `Transfer_status_idx`(`status`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `TransferItem` (
    `id` VARCHAR(191) NOT NULL,
    `transferId` VARCHAR(191) NOT NULL,
    `productId` VARCHAR(191) NOT NULL,
    `quantity` INTEGER NOT NULL,
    `receivedQuantity` INTEGER NOT NULL DEFAULT 0,
    `isFBABundle` BOOLEAN NOT NULL DEFAULT false,
    `fbaSku` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `TransferItem_transferId_idx`(`transferId`),
    INDEX `TransferItem_productId_idx`(`productId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Return` (
    `id` VARCHAR(191) NOT NULL,
    `rmaNumber` VARCHAR(191) NOT NULL,
    `orderId` VARCHAR(191) NULL,
    `customerId` VARCHAR(191) NULL,
    `type` ENUM('RETURN', 'EXCHANGE', 'REFUND', 'WARRANTY') NOT NULL DEFAULT 'RETURN',
    `reason` VARCHAR(191) NULL,
    `status` ENUM('PENDING', 'APPROVED', 'RECEIVING', 'PROCESSING', 'COMPLETED', 'REJECTED', 'CANCELLED') NOT NULL DEFAULT 'PENDING',
    `totalValue` DOUBLE NOT NULL DEFAULT 0,
    `refundAmount` DOUBLE NULL,
    `notes` VARCHAR(191) NULL,
    `requestedAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `receivedAt` DATETIME(3) NULL,
    `processedAt` DATETIME(3) NULL,
    `completedAt` DATETIME(3) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `Return_rmaNumber_key`(`rmaNumber`),
    INDEX `Return_rmaNumber_idx`(`rmaNumber`),
    INDEX `Return_orderId_idx`(`orderId`),
    INDEX `Return_customerId_idx`(`customerId`),
    INDEX `Return_status_idx`(`status`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ReturnItem` (
    `id` VARCHAR(191) NOT NULL,
    `returnId` VARCHAR(191) NOT NULL,
    `productId` VARCHAR(191) NOT NULL,
    `quantity` INTEGER NOT NULL,
    `receivedQuantity` INTEGER NOT NULL DEFAULT 0,
    `condition` VARCHAR(191) NULL,
    `action` ENUM('PENDING', 'RESTOCK', 'DISPOSE', 'REPAIR', 'EXCHANGE') NOT NULL DEFAULT 'PENDING',
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `ReturnItem_returnId_idx`(`returnId`),
    INDEX `ReturnItem_productId_idx`(`productId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Client` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `code` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NULL,
    `phone` VARCHAR(191) NULL,
    `address` VARCHAR(191) NULL,
    `contactName` VARCHAR(191) NULL,
    `companyId` VARCHAR(191) NOT NULL,
    `status` ENUM('ACTIVE', 'INACTIVE', 'SUSPENDED') NOT NULL DEFAULT 'ACTIVE',
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `Client_code_key`(`code`),
    INDEX `Client_companyId_idx`(`companyId`),
    INDEX `Client_code_idx`(`code`),
    INDEX `Client_status_idx`(`status`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Supplier` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `code` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NULL,
    `phone` VARCHAR(191) NULL,
    `address` VARCHAR(191) NULL,
    `companyId` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `Supplier_code_key`(`code`),
    INDEX `Supplier_companyId_idx`(`companyId`),
    INDEX `Supplier_code_idx`(`code`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `PurchaseOrder` (
    `id` VARCHAR(191) NOT NULL,
    `poNumber` VARCHAR(191) NOT NULL,
    `supplierId` VARCHAR(191) NOT NULL,
    `status` ENUM('DRAFT', 'PENDING', 'APPROVED', 'REJECTED', 'PARTIALLY_RECEIVED', 'RECEIVED', 'CANCELLED') NOT NULL DEFAULT 'DRAFT',
    `subtotal` DOUBLE NOT NULL DEFAULT 0,
    `taxAmount` DOUBLE NOT NULL DEFAULT 0,
    `shippingCost` DOUBLE NOT NULL DEFAULT 0,
    `totalAmount` DOUBLE NOT NULL DEFAULT 0,
    `orderDate` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `expectedDelivery` DATETIME(3) NULL,
    `receivedDate` DATETIME(3) NULL,
    `approvedBy` VARCHAR(191) NULL,
    `approvedAt` DATETIME(3) NULL,
    `rejectedBy` VARCHAR(191) NULL,
    `rejectedAt` DATETIME(3) NULL,
    `rejectionReason` VARCHAR(191) NULL,
    `notes` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `PurchaseOrder_poNumber_key`(`poNumber`),
    INDEX `PurchaseOrder_supplierId_idx`(`supplierId`),
    INDEX `PurchaseOrder_status_idx`(`status`),
    INDEX `PurchaseOrder_poNumber_idx`(`poNumber`),
    INDEX `PurchaseOrder_orderDate_idx`(`orderDate`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `PurchaseOrderItem` (
    `id` VARCHAR(191) NOT NULL,
    `purchaseOrderId` VARCHAR(191) NOT NULL,
    `productId` VARCHAR(191) NOT NULL,
    `productName` VARCHAR(191) NOT NULL,
    `productSku` VARCHAR(191) NOT NULL,
    `quantity` INTEGER NOT NULL,
    `receivedQty` INTEGER NOT NULL DEFAULT 0,
    `unitPrice` DOUBLE NOT NULL,
    `totalPrice` DOUBLE NOT NULL,
    `isBundle` BOOLEAN NOT NULL DEFAULT false,
    `bundleQty` INTEGER NULL,
    `notes` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    INDEX `PurchaseOrderItem_purchaseOrderId_idx`(`purchaseOrderId`),
    INDEX `PurchaseOrderItem_productId_idx`(`productId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `GoodsReceipt` (
    `id` VARCHAR(191) NOT NULL,
    `grNumber` VARCHAR(191) NOT NULL,
    `purchaseOrderId` VARCHAR(191) NOT NULL,
    `status` ENUM('PENDING', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED') NOT NULL DEFAULT 'PENDING',
    `receivedBy` VARCHAR(191) NULL,
    `receivedDate` DATETIME(3) NULL,
    `qualityStatus` VARCHAR(191) NULL,
    `qualityNotes` VARCHAR(191) NULL,
    `totalExpected` INTEGER NOT NULL DEFAULT 0,
    `totalReceived` INTEGER NOT NULL DEFAULT 0,
    `totalDamaged` INTEGER NOT NULL DEFAULT 0,
    `notes` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `GoodsReceipt_grNumber_key`(`grNumber`),
    INDEX `GoodsReceipt_purchaseOrderId_idx`(`purchaseOrderId`),
    INDEX `GoodsReceipt_grNumber_idx`(`grNumber`),
    INDEX `GoodsReceipt_status_idx`(`status`),
    INDEX `GoodsReceipt_receivedDate_idx`(`receivedDate`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `GoodsReceiptItem` (
    `id` VARCHAR(191) NOT NULL,
    `goodsReceiptId` VARCHAR(191) NOT NULL,
    `purchaseOrderItemId` VARCHAR(191) NOT NULL,
    `productId` VARCHAR(191) NOT NULL,
    `productName` VARCHAR(191) NOT NULL,
    `productSku` VARCHAR(191) NOT NULL,
    `expectedQty` INTEGER NOT NULL,
    `receivedQty` INTEGER NOT NULL DEFAULT 0,
    `damagedQty` INTEGER NOT NULL DEFAULT 0,
    `batchNumber` VARCHAR(191) NULL,
    `lotNumber` VARCHAR(191) NULL,
    `bestBeforeDate` DATETIME(3) NULL,
    `locationId` VARCHAR(191) NULL,
    `qualityStatus` VARCHAR(191) NULL,
    `qualityNotes` VARCHAR(191) NULL,
    `notes` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    INDEX `GoodsReceiptItem_goodsReceiptId_idx`(`goodsReceiptId`),
    INDEX `GoodsReceiptItem_purchaseOrderItemId_idx`(`purchaseOrderItemId`),
    INDEX `GoodsReceiptItem_productId_idx`(`productId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `SalesChannel` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `code` VARCHAR(191) NOT NULL,
    `type` ENUM('AMAZON_FBA', 'SHOPIFY', 'EBAY', 'DIRECT', 'WHOLESALE', 'CUSTOM') NOT NULL,
    `apiKey` VARCHAR(191) NULL,
    `apiSecret` VARCHAR(191) NULL,
    `webhookUrl` VARCHAR(191) NULL,
    `syncFrequency` INTEGER NULL DEFAULT 5,
    `referralFeePercent` DOUBLE NULL,
    `fixedFee` DOUBLE NULL,
    `fulfillmentFeePerUnit` DOUBLE NULL,
    `storageFeePerUnit` DOUBLE NULL,
    `additionalFees` JSON NULL,
    `isActive` BOOLEAN NOT NULL DEFAULT true,
    `lastSyncAt` DATETIME(3) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `SalesChannel_code_key`(`code`),
    INDEX `SalesChannel_code_idx`(`code`),
    INDEX `SalesChannel_type_idx`(`type`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ChannelPrice` (
    `id` VARCHAR(191) NOT NULL,
    `productId` VARCHAR(191) NOT NULL,
    `channelId` VARCHAR(191) NOT NULL,
    `sellingPrice` DOUBLE NOT NULL,
    `vatRate` DOUBLE NULL,
    `priceExVat` DOUBLE NULL,
    `vatAmount` DOUBLE NULL,
    `priceIncVat` DOUBLE NULL,
    `productCost` DOUBLE NULL,
    `laborCost` DOUBLE NULL,
    `materialCost` DOUBLE NULL,
    `shippingCost` DOUBLE NULL,
    `totalCost` DOUBLE NULL,
    `grossProfit` DOUBLE NULL,
    `profitMargin` DOUBLE NULL,
    `isActive` BOOLEAN NOT NULL DEFAULT true,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    INDEX `ChannelPrice_productId_idx`(`productId`),
    INDEX `ChannelPrice_channelId_idx`(`channelId`),
    UNIQUE INDEX `ChannelPrice_productId_channelId_key`(`productId`, `channelId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `AlternativeSku` (
    `id` VARCHAR(191) NOT NULL,
    `productId` VARCHAR(191) NOT NULL,
    `channel` ENUM('AMAZON_FBA', 'AMAZON_MFN', 'SHOPIFY', 'EBAY', 'TIKTOK', 'TEMU', 'OTHER') NOT NULL,
    `sku` VARCHAR(191) NOT NULL,
    `skuSuffix` VARCHAR(191) NULL,
    `fnsku` VARCHAR(191) NULL,
    `asin` VARCHAR(191) NULL,
    `isActive` BOOLEAN NOT NULL DEFAULT true,
    `companyId` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    INDEX `AlternativeSku_productId_idx`(`productId`),
    INDEX `AlternativeSku_channel_idx`(`channel`),
    INDEX `AlternativeSku_sku_idx`(`sku`),
    INDEX `AlternativeSku_fnsku_idx`(`fnsku`),
    INDEX `AlternativeSku_asin_idx`(`asin`),
    INDEX `AlternativeSku_companyId_idx`(`companyId`),
    UNIQUE INDEX `AlternativeSku_productId_channel_sku_key`(`productId`, `channel`, `sku`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `SupplierProduct` (
    `id` VARCHAR(191) NOT NULL,
    `supplierId` VARCHAR(191) NOT NULL,
    `productId` VARCHAR(191) NOT NULL,
    `supplierSku` VARCHAR(191) NOT NULL,
    `supplierName` VARCHAR(191) NULL,
    `caseSize` INTEGER NOT NULL,
    `caseCost` DOUBLE NULL,
    `unitCost` DOUBLE NULL,
    `isPrimary` BOOLEAN NOT NULL DEFAULT false,
    `leadTimeDays` INTEGER NULL,
    `moq` INTEGER NULL,
    `companyId` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    INDEX `SupplierProduct_productId_idx`(`productId`),
    INDEX `SupplierProduct_supplierId_idx`(`supplierId`),
    INDEX `SupplierProduct_isPrimary_idx`(`isPrimary`),
    INDEX `SupplierProduct_companyId_idx`(`companyId`),
    UNIQUE INDEX `SupplierProduct_supplierId_supplierSku_key`(`supplierId`, `supplierSku`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Consumable` (
    `id` VARCHAR(191) NOT NULL,
    `sku` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `category` ENUM('PACKAGING', 'LABEL', 'PACKING_MATERIAL', 'TAPE', 'STATIONERY', 'OTHER') NOT NULL DEFAULT 'PACKAGING',
    `currentStock` INTEGER NOT NULL DEFAULT 0,
    `minStockLevel` INTEGER NOT NULL DEFAULT 10,
    `unitCost` DOUBLE NOT NULL,
    `companyId` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `Consumable_sku_key`(`sku`),
    INDEX `Consumable_sku_idx`(`sku`),
    INDEX `Consumable_category_idx`(`category`),
    INDEX `Consumable_companyId_idx`(`companyId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ConsumableUsage` (
    `id` VARCHAR(191) NOT NULL,
    `consumableId` VARCHAR(191) NOT NULL,
    `quantity` INTEGER NOT NULL,
    `usedBy` VARCHAR(191) NULL,
    `orderId` VARCHAR(191) NULL,
    `reason` VARCHAR(191) NULL,
    `companyId` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `ConsumableUsage_consumableId_idx`(`consumableId`),
    INDEX `ConsumableUsage_orderId_idx`(`orderId`),
    INDEX `ConsumableUsage_createdAt_idx`(`createdAt`),
    INDEX `ConsumableUsage_companyId_idx`(`companyId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `MarketplaceConnection` (
    `id` VARCHAR(191) NOT NULL,
    `companyId` VARCHAR(191) NOT NULL,
    `marketplace` ENUM('AMAZON_FBA', 'AMAZON_MFN', 'SHOPIFY', 'EBAY', 'TIKTOK', 'TEMU', 'OTHER') NOT NULL,
    `accountName` VARCHAR(191) NOT NULL,
    `apiKey` VARCHAR(191) NULL,
    `apiSecret` VARCHAR(191) NULL,
    `accessToken` VARCHAR(191) NULL,
    `refreshToken` VARCHAR(191) NULL,
    `tokenExpiresAt` DATETIME(3) NULL,
    `sellerId` VARCHAR(191) NULL,
    `clientId` VARCHAR(191) NULL,
    `clientSecret` VARCHAR(191) NULL,
    `awsAccessKeyId` VARCHAR(191) NULL,
    `awsSecretKey` VARCHAR(191) NULL,
    `region` VARCHAR(191) NULL,
    `shopUrl` VARCHAR(191) NULL,
    `shopifyApiKey` VARCHAR(191) NULL,
    `shopifyApiSecret` VARCHAR(191) NULL,
    `shopifyAccessToken` VARCHAR(191) NULL,
    `ebayAppId` VARCHAR(191) NULL,
    `ebayDevId` VARCHAR(191) NULL,
    `ebayCertId` VARCHAR(191) NULL,
    `ebayAuthToken` VARCHAR(191) NULL,
    `ebayRefreshToken` VARCHAR(191) NULL,
    `ebayEnvironment` VARCHAR(191) NULL,
    `storeId` VARCHAR(191) NULL,
    `autoSyncOrders` BOOLEAN NOT NULL DEFAULT true,
    `autoSyncStock` BOOLEAN NOT NULL DEFAULT true,
    `syncFrequency` INTEGER NULL DEFAULT 30,
    `lastSyncAt` DATETIME(3) NULL,
    `lastSyncError` VARCHAR(191) NULL,
    `isActive` BOOLEAN NOT NULL DEFAULT true,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    INDEX `MarketplaceConnection_companyId_idx`(`companyId`),
    INDEX `MarketplaceConnection_marketplace_idx`(`marketplace`),
    INDEX `MarketplaceConnection_isActive_idx`(`isActive`),
    UNIQUE INDEX `MarketplaceConnection_companyId_marketplace_accountName_key`(`companyId`, `marketplace`, `accountName`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `MarketplaceOrderSync` (
    `id` VARCHAR(191) NOT NULL,
    `connectionId` VARCHAR(191) NOT NULL,
    `orderId` VARCHAR(191) NULL,
    `externalOrderId` VARCHAR(191) NOT NULL,
    `status` ENUM('PENDING', 'IN_PROGRESS', 'COMPLETED', 'FAILED') NOT NULL DEFAULT 'PENDING',
    `errorMessage` VARCHAR(191) NULL,
    `orderData` JSON NULL,
    `syncedAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `MarketplaceOrderSync_connectionId_idx`(`connectionId`),
    INDEX `MarketplaceOrderSync_status_idx`(`status`),
    INDEX `MarketplaceOrderSync_syncedAt_idx`(`syncedAt`),
    UNIQUE INDEX `MarketplaceOrderSync_connectionId_externalOrderId_key`(`connectionId`, `externalOrderId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `MarketplaceStockSync` (
    `id` VARCHAR(191) NOT NULL,
    `connectionId` VARCHAR(191) NOT NULL,
    `productId` VARCHAR(191) NOT NULL,
    `sku` VARCHAR(191) NOT NULL,
    `quantitySynced` INTEGER NOT NULL,
    `status` ENUM('PENDING', 'IN_PROGRESS', 'COMPLETED', 'FAILED') NOT NULL DEFAULT 'COMPLETED',
    `errorMessage` VARCHAR(191) NULL,
    `syncedAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    INDEX `MarketplaceStockSync_connectionId_idx`(`connectionId`),
    INDEX `MarketplaceStockSync_productId_idx`(`productId`),
    INDEX `MarketplaceStockSync_status_idx`(`status`),
    INDEX `MarketplaceStockSync_syncedAt_idx`(`syncedAt`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `CourierConnection` (
    `id` VARCHAR(191) NOT NULL,
    `companyId` VARCHAR(191) NOT NULL,
    `courier` ENUM('AMAZON_BUY_SHIPPING', 'ROYAL_MAIL', 'PARCELFORCE', 'DPD_UK', 'EVRI', 'YODEL', 'UPS', 'FEDEX', 'DHL', 'OTHER') NOT NULL,
    `accountName` VARCHAR(191) NOT NULL,
    `apiKey` VARCHAR(191) NULL,
    `apiSecret` VARCHAR(191) NULL,
    `accountNumber` VARCHAR(191) NULL,
    `username` VARCHAR(191) NULL,
    `password` VARCHAR(191) NULL,
    `royalMailApiKey` VARCHAR(191) NULL,
    `royalMailPostingLocation` VARCHAR(191) NULL,
    `parcelforceContractNumber` VARCHAR(191) NULL,
    `dpdGeoSession` VARCHAR(191) NULL,
    `dpdAccountCode` VARCHAR(191) NULL,
    `accessToken` VARCHAR(191) NULL,
    `refreshToken` VARCHAR(191) NULL,
    `tokenExpiresAt` DATETIME(3) NULL,
    `isDefault` BOOLEAN NOT NULL DEFAULT false,
    `isActive` BOOLEAN NOT NULL DEFAULT true,
    `testMode` BOOLEAN NOT NULL DEFAULT false,
    `defaultService` VARCHAR(191) NULL,
    `serviceOptions` JSON NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    INDEX `CourierConnection_companyId_idx`(`companyId`),
    INDEX `CourierConnection_courier_idx`(`courier`),
    INDEX `CourierConnection_isActive_idx`(`isActive`),
    INDEX `CourierConnection_isDefault_idx`(`isDefault`),
    UNIQUE INDEX `CourierConnection_companyId_courier_accountName_key`(`companyId`, `courier`, `accountName`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `CourierShipment` (
    `id` VARCHAR(191) NOT NULL,
    `connectionId` VARCHAR(191) NOT NULL,
    `orderId` VARCHAR(191) NULL,
    `trackingNumber` VARCHAR(191) NOT NULL,
    `labelUrl` VARCHAR(191) NULL,
    `serviceCode` VARCHAR(191) NULL,
    `weight` DOUBLE NULL,
    `cost` DOUBLE NULL,
    `status` ENUM('PENDING', 'LABEL_CREATED', 'PICKED_UP', 'IN_TRANSIT', 'DELIVERED', 'FAILED', 'CANCELLED') NOT NULL DEFAULT 'PENDING',
    `estimatedDelivery` DATETIME(3) NULL,
    `actualDelivery` DATETIME(3) NULL,
    `companyId` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    INDEX `CourierShipment_connectionId_idx`(`connectionId`),
    INDEX `CourierShipment_orderId_idx`(`orderId`),
    INDEX `CourierShipment_status_idx`(`status`),
    INDEX `CourierShipment_trackingNumber_idx`(`trackingNumber`),
    INDEX `CourierShipment_companyId_idx`(`companyId`),
    UNIQUE INDEX `CourierShipment_trackingNumber_key`(`trackingNumber`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `SkuMapping` (
    `id` VARCHAR(191) NOT NULL,
    `companyId` VARCHAR(191) NOT NULL,
    `field` VARCHAR(191) NOT NULL,
    `external` VARCHAR(191) NOT NULL,
    `internal` VARCHAR(191) NOT NULL,
    `channel` VARCHAR(191) NOT NULL,
    `type` ENUM('PRODUCT', 'CUSTOMER', 'ORDER') NOT NULL DEFAULT 'PRODUCT',
    `status` VARCHAR(191) NOT NULL DEFAULT 'active',
    `description` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    INDEX `SkuMapping_companyId_idx`(`companyId`),
    INDEX `SkuMapping_channel_idx`(`channel`),
    INDEX `SkuMapping_type_idx`(`type`),
    UNIQUE INDEX `SkuMapping_companyId_channel_external_type_key`(`companyId`, `channel`, `external`, `type`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `User` ADD CONSTRAINT `User_companyId_fkey` FOREIGN KEY (`companyId`) REFERENCES `Company`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Warehouse` ADD CONSTRAINT `Warehouse_companyId_fkey` FOREIGN KEY (`companyId`) REFERENCES `Company`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Zone` ADD CONSTRAINT `Zone_warehouseId_fkey` FOREIGN KEY (`warehouseId`) REFERENCES `Warehouse`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Location` ADD CONSTRAINT `Location_warehouseId_fkey` FOREIGN KEY (`warehouseId`) REFERENCES `Warehouse`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Location` ADD CONSTRAINT `Location_zoneId_fkey` FOREIGN KEY (`zoneId`) REFERENCES `Zone`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Brand` ADD CONSTRAINT `Brand_companyId_fkey` FOREIGN KEY (`companyId`) REFERENCES `Company`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Product` ADD CONSTRAINT `Product_companyId_fkey` FOREIGN KEY (`companyId`) REFERENCES `Company`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Product` ADD CONSTRAINT `Product_brandId_fkey` FOREIGN KEY (`brandId`) REFERENCES `Brand`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `BundleItem` ADD CONSTRAINT `BundleItem_parentId_fkey` FOREIGN KEY (`parentId`) REFERENCES `Product`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `BundleItem` ADD CONSTRAINT `BundleItem_childId_fkey` FOREIGN KEY (`childId`) REFERENCES `Product`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Inventory` ADD CONSTRAINT `Inventory_productId_fkey` FOREIGN KEY (`productId`) REFERENCES `Product`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Inventory` ADD CONSTRAINT `Inventory_warehouseId_fkey` FOREIGN KEY (`warehouseId`) REFERENCES `Warehouse`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Inventory` ADD CONSTRAINT `Inventory_locationId_fkey` FOREIGN KEY (`locationId`) REFERENCES `Location`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `StockAdjustment` ADD CONSTRAINT `StockAdjustment_warehouseId_fkey` FOREIGN KEY (`warehouseId`) REFERENCES `Warehouse`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `StockAdjustment` ADD CONSTRAINT `StockAdjustment_requestedBy_fkey` FOREIGN KEY (`requestedBy`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `StockAdjustment` ADD CONSTRAINT `StockAdjustment_approvedBy_fkey` FOREIGN KEY (`approvedBy`) REFERENCES `User`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `StockAdjustmentItem` ADD CONSTRAINT `StockAdjustmentItem_adjustmentId_fkey` FOREIGN KEY (`adjustmentId`) REFERENCES `StockAdjustment`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `StockAdjustmentItem` ADD CONSTRAINT `StockAdjustmentItem_productId_fkey` FOREIGN KEY (`productId`) REFERENCES `Product`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `StockAdjustmentItem` ADD CONSTRAINT `StockAdjustmentItem_locationId_fkey` FOREIGN KEY (`locationId`) REFERENCES `Location`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `InventoryMovement` ADD CONSTRAINT `InventoryMovement_productId_fkey` FOREIGN KEY (`productId`) REFERENCES `Product`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `InventoryMovement` ADD CONSTRAINT `InventoryMovement_batchId_fkey` FOREIGN KEY (`batchId`) REFERENCES `Inventory`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `InventoryMovement` ADD CONSTRAINT `InventoryMovement_fromLocationId_fkey` FOREIGN KEY (`fromLocationId`) REFERENCES `Location`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `InventoryMovement` ADD CONSTRAINT `InventoryMovement_toLocationId_fkey` FOREIGN KEY (`toLocationId`) REFERENCES `Location`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `InventoryMovement` ADD CONSTRAINT `InventoryMovement_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `CycleCount` ADD CONSTRAINT `CycleCount_warehouseId_fkey` FOREIGN KEY (`warehouseId`) REFERENCES `Warehouse`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `CycleCountItem` ADD CONSTRAINT `CycleCountItem_cycleCountId_fkey` FOREIGN KEY (`cycleCountId`) REFERENCES `CycleCount`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `CycleCountItem` ADD CONSTRAINT `CycleCountItem_productId_fkey` FOREIGN KEY (`productId`) REFERENCES `Product`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Customer` ADD CONSTRAINT `Customer_companyId_fkey` FOREIGN KEY (`companyId`) REFERENCES `Company`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `SalesOrder` ADD CONSTRAINT `SalesOrder_customerId_fkey` FOREIGN KEY (`customerId`) REFERENCES `Customer`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `SalesOrderItem` ADD CONSTRAINT `SalesOrderItem_orderId_fkey` FOREIGN KEY (`orderId`) REFERENCES `SalesOrder`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `SalesOrderItem` ADD CONSTRAINT `SalesOrderItem_productId_fkey` FOREIGN KEY (`productId`) REFERENCES `Product`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `PickList` ADD CONSTRAINT `PickList_orderId_fkey` FOREIGN KEY (`orderId`) REFERENCES `SalesOrder`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `PickList` ADD CONSTRAINT `PickList_assignedUserId_fkey` FOREIGN KEY (`assignedUserId`) REFERENCES `User`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `PickItem` ADD CONSTRAINT `PickItem_pickListId_fkey` FOREIGN KEY (`pickListId`) REFERENCES `PickList`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `PickItem` ADD CONSTRAINT `PickItem_productId_fkey` FOREIGN KEY (`productId`) REFERENCES `Product`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `PickItem` ADD CONSTRAINT `PickItem_locationId_fkey` FOREIGN KEY (`locationId`) REFERENCES `Location`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ReplenishmentConfig` ADD CONSTRAINT `ReplenishmentConfig_productId_fkey` FOREIGN KEY (`productId`) REFERENCES `Product`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ReplenishmentTask` ADD CONSTRAINT `ReplenishmentTask_productId_fkey` FOREIGN KEY (`productId`) REFERENCES `Product`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Transfer` ADD CONSTRAINT `Transfer_fromWarehouseId_fkey` FOREIGN KEY (`fromWarehouseId`) REFERENCES `Warehouse`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Transfer` ADD CONSTRAINT `Transfer_toWarehouseId_fkey` FOREIGN KEY (`toWarehouseId`) REFERENCES `Warehouse`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `TransferItem` ADD CONSTRAINT `TransferItem_transferId_fkey` FOREIGN KEY (`transferId`) REFERENCES `Transfer`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `TransferItem` ADD CONSTRAINT `TransferItem_productId_fkey` FOREIGN KEY (`productId`) REFERENCES `Product`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Return` ADD CONSTRAINT `Return_orderId_fkey` FOREIGN KEY (`orderId`) REFERENCES `SalesOrder`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Return` ADD CONSTRAINT `Return_customerId_fkey` FOREIGN KEY (`customerId`) REFERENCES `Customer`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ReturnItem` ADD CONSTRAINT `ReturnItem_returnId_fkey` FOREIGN KEY (`returnId`) REFERENCES `Return`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ReturnItem` ADD CONSTRAINT `ReturnItem_productId_fkey` FOREIGN KEY (`productId`) REFERENCES `Product`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Client` ADD CONSTRAINT `Client_companyId_fkey` FOREIGN KEY (`companyId`) REFERENCES `Company`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Supplier` ADD CONSTRAINT `Supplier_companyId_fkey` FOREIGN KEY (`companyId`) REFERENCES `Company`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `PurchaseOrder` ADD CONSTRAINT `PurchaseOrder_supplierId_fkey` FOREIGN KEY (`supplierId`) REFERENCES `Supplier`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `PurchaseOrderItem` ADD CONSTRAINT `PurchaseOrderItem_purchaseOrderId_fkey` FOREIGN KEY (`purchaseOrderId`) REFERENCES `PurchaseOrder`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `GoodsReceipt` ADD CONSTRAINT `GoodsReceipt_purchaseOrderId_fkey` FOREIGN KEY (`purchaseOrderId`) REFERENCES `PurchaseOrder`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `GoodsReceiptItem` ADD CONSTRAINT `GoodsReceiptItem_goodsReceiptId_fkey` FOREIGN KEY (`goodsReceiptId`) REFERENCES `GoodsReceipt`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `GoodsReceiptItem` ADD CONSTRAINT `GoodsReceiptItem_purchaseOrderItemId_fkey` FOREIGN KEY (`purchaseOrderItemId`) REFERENCES `PurchaseOrderItem`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ChannelPrice` ADD CONSTRAINT `ChannelPrice_productId_fkey` FOREIGN KEY (`productId`) REFERENCES `Product`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ChannelPrice` ADD CONSTRAINT `ChannelPrice_channelId_fkey` FOREIGN KEY (`channelId`) REFERENCES `SalesChannel`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `AlternativeSku` ADD CONSTRAINT `AlternativeSku_productId_fkey` FOREIGN KEY (`productId`) REFERENCES `Product`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `SupplierProduct` ADD CONSTRAINT `SupplierProduct_productId_fkey` FOREIGN KEY (`productId`) REFERENCES `Product`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ConsumableUsage` ADD CONSTRAINT `ConsumableUsage_consumableId_fkey` FOREIGN KEY (`consumableId`) REFERENCES `Consumable`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MarketplaceOrderSync` ADD CONSTRAINT `MarketplaceOrderSync_connectionId_fkey` FOREIGN KEY (`connectionId`) REFERENCES `MarketplaceConnection`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `MarketplaceStockSync` ADD CONSTRAINT `MarketplaceStockSync_connectionId_fkey` FOREIGN KEY (`connectionId`) REFERENCES `MarketplaceConnection`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `CourierShipment` ADD CONSTRAINT `CourierShipment_connectionId_fkey` FOREIGN KEY (`connectionId`) REFERENCES `CourierConnection`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
