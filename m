Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1CA3E5A35
	for <lists+linux-crypto@lfdr.de>; Tue, 10 Aug 2021 14:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240746AbhHJMnT (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 10 Aug 2021 08:43:19 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40802 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbhHJMnP (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 10 Aug 2021 08:43:15 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2846022063;
        Tue, 10 Aug 2021 12:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628599372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yc9L4FJH4DzjSrDVrO2auPgn4SAQQ4+MtTuLY6XhdZA=;
        b=zNWYaMbRwtDrmV2+PjF+6kRlvIeLp9r3rzjJHLJw2WK5zwbWjjpM44ZhR1fasshS5zfaTX
        XEmsofsWEMK7+/XlNu/8jNoHM8Jg1x/7sdbNICDoN2tdvUBFTz2Y8+h2y2g2MLJPZkV2Qy
        9lIT5tkdgtFRjcY3w7zYjXNeVLbh1xE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628599372;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yc9L4FJH4DzjSrDVrO2auPgn4SAQQ4+MtTuLY6XhdZA=;
        b=vA582syyUD57YuUM1Cxo9aO+yi3j2Fv9+YTX7ihmZBh4S5dSc873jXQJOTuSyy166HQvGN
        bI71NdQgZWnr2YAg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 195C3A3B92;
        Tue, 10 Aug 2021 12:42:52 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 6E109518C54C; Tue, 10 Aug 2021 14:42:50 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@wdc.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-nvme@lists.infradead.org, linux-crypto@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 06/13] nvme-fabrics: decode 'authentication required' connect error
Date:   Tue, 10 Aug 2021 14:42:23 +0200
Message-Id: <20210810124230.12161-7-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210810124230.12161-1-hare@suse.de>
References: <20210810124230.12161-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The 'connect' command might fail with NVME_SC_AUTH_REQUIRED, so we
should be decoding this error, too.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/fabrics.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index a5469fd9d4c3..1e9900f72e66 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -332,6 +332,10 @@ static void nvmf_log_connect_error(struct nvme_ctrl *ctrl,
 		dev_err(ctrl->device,
 			"Connect command failed: host path error\n");
 		break;
+	case NVME_SC_AUTH_REQUIRED:
+		dev_err(ctrl->device,
+			"Connect command failed: authentication required\n");
+		break;
 	default:
 		dev_err(ctrl->device,
 			"Connect command failed, error wo/DNR bit: %d\n",
-- 
2.29.2

