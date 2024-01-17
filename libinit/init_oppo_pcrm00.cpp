/*
 * Copyright (C) 2021 The LineageOS Project
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <libinit_variant.h>

#include "vendor_init.h"

static const variant_info_t PCRM00_CN_info = {

    .device = "PCRM00CN",
    .model = "PCRM00",
    .name = "PCRM00",
};

static const std::vector<variant_info_t> variants = {
    PCRM00_CN_info,
};
