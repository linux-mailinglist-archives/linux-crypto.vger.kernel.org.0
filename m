Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9F138A1F3
	for <lists+linux-crypto@lfdr.de>; Thu, 20 May 2021 11:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbhETJgf (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 20 May 2021 05:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbhETJed (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 20 May 2021 05:34:33 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB723C0612A7
        for <linux-crypto@vger.kernel.org>; Thu, 20 May 2021 02:27:40 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id f75-20020a1c1f4e0000b0290171001e7329so4778976wmf.1
        for <linux-crypto@vger.kernel.org>; Thu, 20 May 2021 02:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ev36AD8P1tZ8Io8ti68c31JmA1kiPIGkayWSiC/TI+Q=;
        b=eRfsQDwEm/ebGY/glkv9Xwd2xAvNwThENHMMC7CHV3o4wqFsoWtFq4rare1gg9pmx9
         T0UldRmt9aEGk/eSuxGRRDi8Cejeii9HEvUyPSTPIEVtz2hCvlohXtLQSVbP/cxwMUMl
         mcDWd6xWgM9cQLvUhxYuiNFDnd6/5uSSzK9T6bONB2qExE4tgsBQWRLqJtuibVENhEQK
         +lU/stGTI9kyhV/1JLm8DlGq5tyAQyLvOptpUSnIBTKhj9J4la7QDPanmGuRzrE1CTpK
         DHGODIhixjNXunQWOam4FSkrIyUYgr59p+4X0IYncpfCaP2Sog/4VvzKTL4kLUt1bllE
         duDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ev36AD8P1tZ8Io8ti68c31JmA1kiPIGkayWSiC/TI+Q=;
        b=AHobm4KXR/1Agh2cMt9JomGJYPhY0/1O94a3rHeFq0e6PHbuNKsbhcF8q/eV5T8awq
         AUIQrJnSZHF6p96uTDXXxLqxK/+o/n4lSRtagKgRzUCokdWzV589rsXFVrVVkgLA0asi
         qM2QkQmeOR3CN5IYrohKE0J9deVQ9OqEcTvsMZz62L7IQPc9/BIubJAvoniUtNgQ6yBb
         beLA/UZ2x/H+UZ73LMy9u0I8O9D833pKHw3kodVIm3HjR+gSTJolvwf84yJLJsUKAU74
         ZNPdPK/Vu7dhz8E3UlpZYDUgevILN8UxlRYY6dIVPjkApbkJSQUzvTELzxYpgqfovJjf
         PJCQ==
X-Gm-Message-State: AOAM531Cwa4mizNlXv6Rc7AA9Ldexy+n9qpNMJKCIWaC8n/4PMU8UVJL
        pw+TaLNiHXZ3snPdh9DW2Co02w==
X-Google-Smtp-Source: ABdhPJyKv98dmQ8FbNJOLTNBePZq7HZCtNU3K1hIM8XiMoixuN+EEgxdK+Do0V7LXKJ8if8wKdbpoA==
X-Received: by 2002:a7b:c752:: with SMTP id w18mr3057460wmk.56.1621502859277;
        Thu, 20 May 2021 02:27:39 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id u11sm722971wrw.14.2021.05.20.02.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 02:27:38 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Gary R Hook <gary.hook@amd.com>, linux-crypto@vger.kernel.org
Subject: [PATCH 3/3] crypto: ccp: ccp-dev: Fix a little doc-rot
Date:   Thu, 20 May 2021 10:27:33 +0100
Message-Id: <20210520092733.3434378-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520092733.3434378-1-lee.jones@linaro.org>
References: <20210520092733.3434378-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/crypto/ccp/ccp-dev.c:476: warning: Function parameter or member 'sp' not described in 'ccp_alloc_struct'
 drivers/crypto/ccp/ccp-dev.c:476: warning: Excess function parameter 'dev' description in 'ccp_alloc_struct'
 drivers/crypto/ccp/ccp-dev.c:476: warning: Function parameter or member 'sp' not described in 'ccp_alloc_struct'
 drivers/crypto/ccp/ccp-dev.c:476: warning: Excess function parameter 'dev' description in 'ccp_alloc_struct'

Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: John Allen <john.allen@amd.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Gary R Hook <gary.hook@amd.com>
Cc: linux-crypto@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/crypto/ccp/ccp-dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/ccp/ccp-dev.c b/drivers/crypto/ccp/ccp-dev.c
index 6777582aa1cee..9ce4b68e9c483 100644
--- a/drivers/crypto/ccp/ccp-dev.c
+++ b/drivers/crypto/ccp/ccp-dev.c
@@ -470,7 +470,7 @@ int ccp_cmd_queue_thread(void *data)
 /**
  * ccp_alloc_struct - allocate and initialize the ccp_device struct
  *
- * @dev: device struct of the CCP
+ * @sp: sp_device struct of the CCP
  */
 struct ccp_device *ccp_alloc_struct(struct sp_device *sp)
 {
-- 
2.31.1

