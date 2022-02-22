Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18814BFEB3
	for <lists+linux-crypto@lfdr.de>; Tue, 22 Feb 2022 17:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbiBVQdI (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 22 Feb 2022 11:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbiBVQc6 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 22 Feb 2022 11:32:58 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBB5BB091;
        Tue, 22 Feb 2022 08:32:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8002FCE17A9;
        Tue, 22 Feb 2022 16:32:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F19C340F3;
        Tue, 22 Feb 2022 16:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645547548;
        bh=gOLNNSW5Geh3wfVR6/JfYsAKw6uI81oMxU3qD4ONSO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e7jmaeyldiXqtvDN0SHe+Ksme9c2hBoEjnr1DskEQOJsgVm1SU/h0W9mgYhg3PkyJ
         B68+r63Q2+5GWP3L4iZh8uXG58LktLBdRrLbYEEJ4vYa1EY3/4v5pX/IIFHZSjMO9w
         uS/Q08XWFZOA+dTfG0qWXnuZWlG/w1OZmBndFL9MsPIJF2p6GrPOf6dGKNCYBn0U71
         72CpMVadCsBpw3nT4yCTRKqob30p+Jpjn8YgdIF6FErJSPyh/AVTAN546hUZB0Oy2v
         GyGlkksfvQ+N1AnW8OfTqphOmQeVZtKW/e7GMrQ9FUBHiThF3cqGbXMrxvhaWic/qY
         yK6saR6GFmGIQ==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        colyli@suse.de, Keith Busch <kbusch@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Klaus Jensen <its@irrelevant.dk>
Subject: [PATCHv3 09/10] nvme: add support for enhanced metadata
Date:   Tue, 22 Feb 2022 08:31:43 -0800
Message-Id: <20220222163144.1782447-10-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20220222163144.1782447-1-kbusch@kernel.org>
References: <20220222163144.1782447-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

NVM Express ratified TP 4068 defines new protection information formats.
Implement support for the CRC64 guard tags.

Since the block layer doesn't support variable length reference tags,
driver support for the Storage Tag space is not supported at this time.

Cc: Hannes Reinecke <hare@suse.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Klaus Jensen <its@irrelevant.dk>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 172 ++++++++++++++++++++++++++++++++-------
 drivers/nvme/host/nvme.h |   4 +-
 include/linux/nvme.h     |  53 ++++++++++--
 3 files changed, 191 insertions(+), 38 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8132b1282082..5599c84ec5ec 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -918,6 +918,30 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 	return BLK_STS_OK;
 }
 
+static inline void nvme_set_ref_tag(struct nvme_ns *ns, struct nvme_command *cmnd,
+				    struct request *req)
+{
+	u32 upper, lower;
+	u64 ref48;
+
+	/* both rw and write zeroes share the same reftag format */
+	switch (ns->guard_type) {
+	case NVME_NVM_NS_16B_GUARD:
+		cmnd->rw.reftag = cpu_to_le32(t10_pi_ref_tag(req));
+		break;
+	case NVME_NVM_NS_64B_GUARD:
+		ref48 = nvme_pi_extended_ref_tag(req);
+		lower = lower_32_bits(ref48);
+		upper = upper_32_bits(ref48);
+
+		cmnd->rw.reftag = cpu_to_le32(lower);
+		cmnd->rw.cdw3 = cpu_to_le32(upper);
+		break;
+	default:
+		break;
+	}
+}
+
 static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
 		struct request *req, struct nvme_command *cmnd)
 {
@@ -939,8 +963,7 @@ static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
 		switch (ns->pi_type) {
 		case NVME_NS_DPS_PI_TYPE1:
 		case NVME_NS_DPS_PI_TYPE2:
-			cmnd->write_zeroes.reftag =
-				cpu_to_le32(t10_pi_ref_tag(req));
+			nvme_set_ref_tag(ns, cmnd, req);
 			break;
 		}
 	}
@@ -967,7 +990,8 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 	cmnd->rw.opcode = op;
 	cmnd->rw.flags = 0;
 	cmnd->rw.nsid = cpu_to_le32(ns->head->ns_id);
-	cmnd->rw.rsvd2 = 0;
+	cmnd->rw.cdw2 = 0;
+	cmnd->rw.cdw3 = 0;
 	cmnd->rw.metadata = 0;
 	cmnd->rw.slba = cpu_to_le64(nvme_sect_to_lba(ns, blk_rq_pos(req)));
 	cmnd->rw.length = cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
@@ -1001,7 +1025,7 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 					NVME_RW_PRINFO_PRCHK_REF;
 			if (op == nvme_cmd_zone_append)
 				control |= NVME_RW_APPEND_PIREMAP;
-			cmnd->rw.reftag = cpu_to_le32(t10_pi_ref_tag(req));
+			nvme_set_ref_tag(ns, cmnd, req);
 			break;
 		}
 	}
@@ -1653,33 +1677,58 @@ int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 }
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
-static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type,
+static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns *ns,
 				u32 max_integrity_segments)
 {
 	struct blk_integrity integrity = { };
 
-	switch (pi_type) {
+	switch (ns->pi_type) {
 	case NVME_NS_DPS_PI_TYPE3:
-		integrity.profile = &t10_pi_type3_crc;
-		integrity.tag_size = sizeof(u16) + sizeof(u32);
-		integrity.flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
+		switch (ns->guard_type) {
+		case NVME_NVM_NS_16B_GUARD:
+			integrity.profile = &t10_pi_type3_crc;
+			integrity.tag_size = sizeof(u16) + sizeof(u32);
+			integrity.flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
+			break;
+		case NVME_NVM_NS_64B_GUARD:
+			integrity.profile = &nvme_pi_type3_crc64;
+			integrity.tag_size = sizeof(u16) + 6;
+			integrity.flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
+			break;
+		default:
+			integrity.profile = NULL;
+			break;
+		}
 		break;
 	case NVME_NS_DPS_PI_TYPE1:
 	case NVME_NS_DPS_PI_TYPE2:
-		integrity.profile = &t10_pi_type1_crc;
-		integrity.tag_size = sizeof(u16);
-		integrity.flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
+		switch (ns->guard_type) {
+		case NVME_NVM_NS_16B_GUARD:
+			integrity.profile = &t10_pi_type1_crc;
+			integrity.tag_size = sizeof(u16);
+			integrity.flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
+			break;
+		case NVME_NVM_NS_64B_GUARD:
+			integrity.profile = &nvme_pi_type1_crc64;
+			integrity.tag_size = sizeof(u16);
+			integrity.flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
+			break;
+		default:
+			integrity.profile = NULL;
+			break;
+		}
 		break;
 	default:
 		integrity.profile = NULL;
 		break;
 	}
-	integrity.tuple_size = ms;
+
+	integrity.tuple_size = ns->ms;
 	blk_integrity_register(disk, &integrity);
 	blk_queue_max_integrity_segments(disk->queue, max_integrity_segments);
 }
 #else
-static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type,
+static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns *ns,
 				u32 max_integrity_segments)
 {
 }
@@ -1756,20 +1805,76 @@ static int nvme_setup_streams_ns(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	return 0;
 }
 
-static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
+static int nvme_init_ms(struct nvme_ns *ns, struct nvme_id_ns *id)
 {
+	bool first = id->dps & NVME_NS_DPS_PI_FIRST;
+	unsigned lbaf = nvme_lbaf_index(id->flbas);
 	struct nvme_ctrl *ctrl = ns->ctrl;
+	struct nvme_command c = { };
+	struct nvme_id_ns_nvm *nvm;
+	int ret = 0;
+	u32 elbaf;
+
+	ns->pi_size = 0;
+	ns->ms = le16_to_cpu(id->lbaf[lbaf].ms);
+	if (!(ctrl->ctratt & NVME_CTRL_ATTR_ELBAS)) {
+		ns->pi_size = sizeof(struct t10_pi_tuple);
+		ns->guard_type = NVME_NVM_NS_16B_GUARD;
+		goto set_pi;
+	}
+
+	nvm = kzalloc(sizeof(*nvm), GFP_KERNEL);
+	if (!nvm)
+		return -ENOMEM;
+
+	c.identify.opcode = nvme_admin_identify;
+	c.identify.nsid = cpu_to_le32(ns->head->ns_id);
+	c.identify.cns = NVME_ID_CNS_CS_NS;
+	c.identify.csi = NVME_CSI_NVM;
 
-	ns->ms = le16_to_cpu(id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ms);
-	if (id->dps & NVME_NS_DPS_PI_FIRST ||
-	    ns->ms == sizeof(struct t10_pi_tuple))
+	ret = nvme_submit_sync_cmd(ns->ctrl->admin_q, &c, nvm, sizeof(*nvm));
+	if (ret)
+		goto free_data;
+
+	elbaf = le32_to_cpu(nvm->elbaf[lbaf]);
+
+	/* no support for storage tag formats right now */
+	if (nvme_elbaf_sts(elbaf))
+		goto free_data;
+
+	ns->guard_type = nvme_elbaf_guard_type(elbaf);
+	switch (ns->guard_type) {
+	case NVME_NVM_NS_64B_GUARD:
+		ns->pi_size = sizeof(struct nvme_crc64_pi_tuple);
+		break;
+	case NVME_NVM_NS_16B_GUARD:
+		ns->pi_size = sizeof(struct t10_pi_tuple);
+		break;
+	default:
+		break;
+	}
+
+free_data:
+	kfree(nvm);
+set_pi:
+	if (ns->pi_size && (first || ns->ms == ns->pi_size))
 		ns->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
 	else
 		ns->pi_type = 0;
 
+	return ret;
+}
+
+static void nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
+{
+	struct nvme_ctrl *ctrl = ns->ctrl;
+
+	if (nvme_init_ms(ns, id))
+		return;
+
 	ns->features &= ~(NVME_NS_METADATA_SUPPORTED | NVME_NS_EXT_LBAS);
 	if (!ns->ms || !(ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
-		return 0;
+		return;
 	if (ctrl->ops->flags & NVME_F_FABRICS) {
 		/*
 		 * The NVMe over Fabrics specification only supports metadata as
@@ -1777,7 +1882,7 @@ static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
 		 * remap the separate metadata buffer from the block layer.
 		 */
 		if (WARN_ON_ONCE(!(id->flbas & NVME_NS_FLBAS_META_EXT)))
-			return -EINVAL;
+			return;
 
 		ns->features |= NVME_NS_EXT_LBAS;
 
@@ -1804,8 +1909,6 @@ static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
 		else
 			ns->features |= NVME_NS_METADATA_SUPPORTED;
 	}
-
-	return 0;
 }
 
 static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
@@ -1884,7 +1987,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	if (ns->ms) {
 		if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
 		    (ns->features & NVME_NS_METADATA_SUPPORTED))
-			nvme_init_integrity(disk, ns->ms, ns->pi_type,
+			nvme_init_integrity(disk, ns,
 					    ns->ctrl->max_integrity_segments);
 		else if (!nvme_ns_has_pi(ns))
 			capacity = 0;
@@ -1939,16 +2042,14 @@ static void nvme_set_chunk_sectors(struct nvme_ns *ns, struct nvme_id_ns *id)
 
 static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 {
-	unsigned lbaf = id->flbas & NVME_NS_FLBAS_LBA_MASK;
+	unsigned lbaf = nvme_lbaf_index(id->flbas);
 	int ret;
 
 	blk_mq_freeze_queue(ns->disk->queue);
 	ns->lba_shift = id->lbaf[lbaf].ds;
 	nvme_set_queue_limits(ns->ctrl, ns->queue);
 
-	ret = nvme_configure_metadata(ns, id);
-	if (ret)
-		goto out_unfreeze;
+	nvme_configure_metadata(ns, id);
 	nvme_set_chunk_sectors(ns, id);
 	nvme_update_disk_info(ns->disk, ns, id);
 
@@ -2286,20 +2387,27 @@ static int nvme_configure_timestamp(struct nvme_ctrl *ctrl)
 	return ret;
 }
 
-static int nvme_configure_acre(struct nvme_ctrl *ctrl)
+static int nvme_configure_host_options(struct nvme_ctrl *ctrl)
 {
 	struct nvme_feat_host_behavior *host;
+	u8 acre = 0, lbafee = 0;
 	int ret;
 
 	/* Don't bother enabling the feature if retry delay is not reported */
-	if (!ctrl->crdt[0])
+	if (ctrl->crdt[0])
+		acre = NVME_ENABLE_ACRE;
+	if (ctrl->ctratt & NVME_CTRL_ATTR_ELBAS)
+		lbafee = NVME_ENABLE_LBAFEE;
+
+	if (!acre && !lbafee)
 		return 0;
 
 	host = kzalloc(sizeof(*host), GFP_KERNEL);
 	if (!host)
 		return 0;
 
-	host->acre = NVME_ENABLE_ACRE;
+	host->acre = acre;
+	host->lbafee = lbafee;
 	ret = nvme_set_features(ctrl, NVME_FEAT_HOST_BEHAVIOR, 0,
 				host, sizeof(*host), NULL);
 	kfree(host);
@@ -3141,7 +3249,7 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
 	if (ret < 0)
 		return ret;
 
-	ret = nvme_configure_acre(ctrl);
+	ret = nvme_configure_host_options(ctrl);
 	if (ret < 0)
 		return ret;
 
@@ -4814,12 +4922,14 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_id_ctrl) != NVME_IDENTIFY_DATA_SIZE);
 	BUILD_BUG_ON(sizeof(struct nvme_id_ns) != NVME_IDENTIFY_DATA_SIZE);
 	BUILD_BUG_ON(sizeof(struct nvme_id_ns_zns) != NVME_IDENTIFY_DATA_SIZE);
+	BUILD_BUG_ON(sizeof(struct nvme_id_ns_nvm) != NVME_IDENTIFY_DATA_SIZE);
 	BUILD_BUG_ON(sizeof(struct nvme_id_ctrl_zns) != NVME_IDENTIFY_DATA_SIZE);
 	BUILD_BUG_ON(sizeof(struct nvme_id_ctrl_nvm) != NVME_IDENTIFY_DATA_SIZE);
 	BUILD_BUG_ON(sizeof(struct nvme_lba_range_type) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_smart_log) != 512);
 	BUILD_BUG_ON(sizeof(struct nvme_dbbuf) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_directive_cmd) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_feat_host_behavior) != 512);
 }
 
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 587d92df118b..77257e02ef03 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -454,9 +454,11 @@ struct nvme_ns {
 
 	int lba_shift;
 	u16 ms;
+	u16 pi_size;
 	u16 sgs;
 	u32 sws;
 	u8 pi_type;
+	u8 guard_type;
 #ifdef CONFIG_BLK_DEV_ZONED
 	u64 zsze;
 #endif
@@ -479,7 +481,7 @@ struct nvme_ns {
 /* NVMe ns supports metadata actions by the controller (generate/strip) */
 static inline bool nvme_ns_has_pi(struct nvme_ns *ns)
 {
-	return ns->pi_type && ns->ms == sizeof(struct t10_pi_tuple);
+	return ns->pi_type && ns->ms == ns->pi_size;
 }
 
 struct nvme_ctrl_ops {
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 9dbc3ef4daf7..4f44f83817a9 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -244,6 +244,7 @@ enum {
 enum nvme_ctrl_attr {
 	NVME_CTRL_ATTR_HID_128_BIT	= (1 << 0),
 	NVME_CTRL_ATTR_TBKAS		= (1 << 6),
+	NVME_CTRL_ATTR_ELBAS		= (1 << 15),
 };
 
 struct nvme_id_ctrl {
@@ -399,8 +400,7 @@ struct nvme_id_ns {
 	__le16			endgid;
 	__u8			nguid[16];
 	__u8			eui64[8];
-	struct nvme_lbaf	lbaf[16];
-	__u8			rsvd192[192];
+	struct nvme_lbaf	lbaf[64];
 	__u8			vs[3712];
 };
 
@@ -418,8 +418,7 @@ struct nvme_id_ns_zns {
 	__le32			rrl;
 	__le32			frl;
 	__u8			rsvd20[2796];
-	struct nvme_zns_lbafe	lbafe[16];
-	__u8			rsvd3072[768];
+	struct nvme_zns_lbafe	lbafe[64];
 	__u8			vs[256];
 };
 
@@ -428,6 +427,30 @@ struct nvme_id_ctrl_zns {
 	__u8	rsvd1[4095];
 };
 
+struct nvme_id_ns_nvm {
+	__le64	lbstm;
+	__u8	pic;
+	__u8	rsvd9[3];
+	__le32	elbaf[64];
+	__u8	rsvd268[3828];
+};
+
+enum {
+	NVME_ID_NS_NVM_STS_MASK		= 0x3f,
+	NVME_ID_NS_NVM_GUARD_SHIFT	= 7,
+	NVME_ID_NS_NVM_GUARD_MASK	= 0x3,
+};
+
+static inline __u8 nvme_elbaf_sts(__u32 elbaf)
+{
+	return elbaf & NVME_ID_NS_NVM_STS_MASK;
+}
+
+static inline __u8 nvme_elbaf_guard_type(__u32 elbaf)
+{
+	return (elbaf >> NVME_ID_NS_NVM_GUARD_SHIFT) & NVME_ID_NS_NVM_GUARD_MASK;
+}
+
 struct nvme_id_ctrl_nvm {
 	__u8	vsl;
 	__u8	wzsl;
@@ -478,6 +501,8 @@ enum {
 	NVME_NS_FEAT_IO_OPT	= 1 << 4,
 	NVME_NS_ATTR_RO		= 1 << 0,
 	NVME_NS_FLBAS_LBA_MASK	= 0xf,
+	NVME_NS_FLBAS_LBA_UMASK	= 0x60,
+	NVME_NS_FLBAS_LBA_SHIFT	= 1,
 	NVME_NS_FLBAS_META_EXT	= 0x10,
 	NVME_NS_NMIC_SHARED	= 1 << 0,
 	NVME_LBAF_RP_BEST	= 0,
@@ -496,6 +521,18 @@ enum {
 	NVME_NS_DPS_PI_TYPE3	= 3,
 };
 
+enum {
+	NVME_NVM_NS_16B_GUARD	= 0,
+	NVME_NVM_NS_32B_GUARD	= 1,
+	NVME_NVM_NS_64B_GUARD	= 2,
+};
+
+static inline __u8 nvme_lbaf_index(__u8 flbas)
+{
+	return (flbas & NVME_NS_FLBAS_LBA_MASK) |
+		((flbas & NVME_NS_FLBAS_LBA_UMASK) >> NVME_NS_FLBAS_LBA_SHIFT);
+}
+
 /* Identify Namespace Metadata Capabilities (MC): */
 enum {
 	NVME_MC_EXTENDED_LBA	= (1 << 0),
@@ -842,7 +879,8 @@ struct nvme_rw_command {
 	__u8			flags;
 	__u16			command_id;
 	__le32			nsid;
-	__u64			rsvd2;
+	__le32			cdw2;
+	__le32			cdw3;
 	__le64			metadata;
 	union nvme_data_ptr	dptr;
 	__le64			slba;
@@ -996,11 +1034,14 @@ enum {
 
 struct nvme_feat_host_behavior {
 	__u8 acre;
-	__u8 resv1[511];
+	__u8 etdas;
+	__u8 lbafee;
+	__u8 resv1[509];
 };
 
 enum {
 	NVME_ENABLE_ACRE	= 1,
+	NVME_ENABLE_LBAFEE	= 1,
 };
 
 /* Admin commands */
-- 
2.25.4

