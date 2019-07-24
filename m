Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF6F72950
	for <lists+linux-crypto@lfdr.de>; Wed, 24 Jul 2019 09:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbfGXHyr (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 24 Jul 2019 03:54:47 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42403 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfGXHyq (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 24 Jul 2019 03:54:46 -0400
Received: by mail-pl1-f194.google.com with SMTP id ay6so21700096plb.9
        for <linux-crypto@vger.kernel.org>; Wed, 24 Jul 2019 00:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xuuerq01hI+vl9rnb4MEMb4bf4fzxdSxAGwMaZGuVJM=;
        b=DRB3NB38SxuG+lydWEZKXFdilJ8RuR2CPicUPzqjtkMbX/ply2EbIeXB01q1opVrGc
         AeYquhOe5gSB7LkrW3XG/bdJe8CfknTBs2z7eQ17LcVYa9VqJwC+7MlPkNd/YXqCjDbw
         /Stpiww1qzfTWnzSGzH8Whhec/hqUPk7uHRhu90sPEhfPQECw/AXQIXlToP86FDc/B5v
         O8GDc2A8NHA5EAaBNyYK/W6m4IkuSJ2BQq/a7A5BkKM+WiG6n7MO7VghhpWGDTOIsADG
         As4oczs5cbcYfQYMveerwo1WiMaGaxbdbUPo2ERztIieIcXTqe4hnD1zUr7FEUQtx/lb
         vSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xuuerq01hI+vl9rnb4MEMb4bf4fzxdSxAGwMaZGuVJM=;
        b=lEJ1IDL5AwQL7z/4XTbzqxdQ6ljqzlwOM+omXdvxxpI7KIVTM/IF8dzeGtjPLr/VMS
         p4GNVUiTrXwsHCGVYoleGXCaXfzUE8Xecm+WWt7pgjqDDgjSk9MJroBnby2nFVF1/72g
         vnJlmSP6KiDvtDaTQTtWKcRLt7tInvB2Mu4z/LxyXQ/QulggZHu391mvE29Dxox1LZYg
         PgEbMBDVIiLkgQ5pDKGtdjKOtGuhRO0KAAQKdt6a+oCccn11toFBjTaGB5EZrClBNHMp
         E9ZarkdKPuFWjkdSsaqfnWh6DplzRPzYtSSqdgWQsrkPofouazaWskvGgQZm6WSmYZhb
         LBlA==
X-Gm-Message-State: APjAAAWnCLl6212eFGZXdTzw47aQ4IN+e5tc6FNWUuICRQbjG6NHjEle
        pWj+W7T6dWuDfgRSWIo8+ippPQcv
X-Google-Smtp-Source: APXvYqznSF/YiWx6bW5BS3Sw9H4C6aV48SBnIKYhYXEA8W+q0aiaWzFs11Lb5qrnzS3lkhHn2SvSPw==
X-Received: by 2002:a17:902:4623:: with SMTP id o32mr83153528pld.112.1563954886243;
        Wed, 24 Jul 2019 00:54:46 -0700 (PDT)
Received: from localhost.localdomain ([110.227.69.93])
        by smtp.gmail.com with ESMTPSA id o130sm74698084pfg.171.2019.07.24.00.54.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 00:54:45 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     haren@us.ibm.com, herbert@gondor.apana.org.au, davem@davemloft.net,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH v2] crypto: nx: nx-842-powernv: Add of_node_put() before return
Date:   Wed, 24 Jul 2019 13:24:33 +0530
Message-Id: <20190724075433.9446-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Each iteration of for_each_compatible_node puts the previous node, but
in the case of a return from the middle of the loop, there is no put,
thus causing a memory leak. Add an of_node_put before the return.
Issue found with Coccinelle.

Acked-by: Stewart Smith <stewart@linux.ibm.com>
Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>

---
Changes in v2:
- Fixed commit message to match the loop in question.

 drivers/crypto/nx/nx-842-powernv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/nx/nx-842-powernv.c b/drivers/crypto/nx/nx-842-powernv.c
index e78ff5c65ed6..c037a2403b82 100644
--- a/drivers/crypto/nx/nx-842-powernv.c
+++ b/drivers/crypto/nx/nx-842-powernv.c
@@ -1020,6 +1020,7 @@ static __init int nx842_powernv_init(void)
 		ret = nx842_powernv_probe_vas(dn);
 		if (ret) {
 			nx842_delete_coprocs();
+			of_node_put(dn);
 			return ret;
 		}
 	}
-- 
2.19.1

