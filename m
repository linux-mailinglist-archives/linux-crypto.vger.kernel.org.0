Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49A8997D19
	for <lists+linux-crypto@lfdr.de>; Wed, 21 Aug 2019 16:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbfHUOdd (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 21 Aug 2019 10:33:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38026 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728763AbfHUOdd (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 21 Aug 2019 10:33:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id m125so2374422wmm.3
        for <linux-crypto@vger.kernel.org>; Wed, 21 Aug 2019 07:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sC43Om6eeDsRfZHSH+k26Uj2fDnNk/GMWHykpA6ile0=;
        b=KHIyiJn3OtTRIQvm1PYKU/9kDRYLCxV2hveKRFmLfNkGD5bO7sbwOhpfv/BB9DtMLK
         m1mPaG4jbae6HTYi4I7lzFpPPS1JNgSy7EaU4KsezWT0ys34L3JVfgytJgTmsxHjFkaM
         1n+EPl9Zf1G7pzB8M/wGmOrH4MLeCy0b+y6rJzAszfAQk5yttEaULGJx9Il8AT8IVgdM
         McFI1njQs6FAzjr/21NjR86yU5Gt4iE06GWSdsksAqMCYvImIHH0dezH0etMccLfRAcp
         unkaql93n7bkCaTywHV5vZXpvvvUKSr8x2c+H7KgtmsVu6HgkFkY/1sgkRgR4AtcvypM
         johg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sC43Om6eeDsRfZHSH+k26Uj2fDnNk/GMWHykpA6ile0=;
        b=Hu0aReWhDdkmTu8qcGkWn9aUq6XJc+JPUpY1zDCwNNnMCde1rpaiEgvMLtfcn9RYmn
         b0cV8OXSlomfO65a3DGu9WaknANIiY+hshrRGbvp/7Hzup3kQaH3JI0PxQNkt/2Lg20x
         3Iw+MfbcOks/biMdPsxVBNFG3uHakacgSiv8E042wAXfbqJYKIclyghd++aBDNlrteSE
         g9ujSBYRT2lL287P1zlgw0WIGmbVGtg23Z//5umMCpb2bfSCp2HSTgQ/FyevKk8yXdfG
         QRPuG6SVwgpNDZV60XgIm67xmD4ArAzKalfvdsGsjGe0fNMFljVxpnP45zDUj7mhImhh
         LP5Q==
X-Gm-Message-State: APjAAAVFZggYMFJSXHlonJ/pzBsQwlg7fvIdeFR2tMk37wh7sOx+pMOc
        MmBZEzT2nhMcZFq2CxEwsSzLmXkI9zbzdg==
X-Google-Smtp-Source: APXvYqxbhfbC3ap8poCnOzQfvKYv3uKl89wuoJ7jg4mTxcU7YygM8pR+EQEYZ5CCisLm2V0yEjbIiw==
X-Received: by 2002:a05:600c:228e:: with SMTP id 14mr362429wmf.101.1566398009231;
        Wed, 21 Aug 2019 07:33:29 -0700 (PDT)
Received: from mba13.lan (adsl-103.109.242.1.tellas.gr. [109.242.1.103])
        by smtp.gmail.com with ESMTPSA id 16sm181427wmx.45.2019.08.21.07.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 07:33:28 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, ebiggers@kernel.org,
        Pascal van Leeuwen <pvanleeuwen@verimatrix.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 17/17] crypto: testmgr - Add additional AES-XTS vectors for covering CTS
Date:   Wed, 21 Aug 2019 17:32:53 +0300
Message-Id: <20190821143253.30209-18-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821143253.30209-1-ard.biesheuvel@linaro.org>
References: <20190821143253.30209-1-ard.biesheuvel@linaro.org>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Pascal van Leeuwen <pvanleeuwen@verimatrix.com>

This patch adds test vectors for AES-XTS that cover data inputs that are
not a multiple of 16 bytes and therefore require cipher text stealing
(CTS) to be applied. Vectors were added to cover all possible alignments
combined with various interesting (i.e. for vector implementations working
on 3,4,5 or 8 AES blocks in parallel) lengths.

This code was kindly donated to the public domain by the author.

Link: https://lore.kernel.org/linux-crypto/MN2PR20MB29739591E1A3E54E7A8A8E18CAC00@MN2PR20MB2973.namprd20.prod.outlook.com/
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 crypto/testmgr.h | 308 ++++++++++++++++++++
 1 file changed, 308 insertions(+)

diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index b88a1ba87b58..717b9fcb9bfa 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -15351,6 +15351,314 @@ static const struct cipher_testvec aes_xts_tv_template[] = {
 			  "\x7b\xe3\xf6\x61\x71\xc7\xc5\xc2"
 			  "\xed\xbf\x9d\xac",
 		.len	= 20,
+	/* Additional vectors to increase CTS coverage */
+	}, { /* 1 block + 21 bytes */
+		.key    = "\xa1\x34\x0e\x49\x38\xfd\x8b\xf6"
+			  "\x45\x60\x67\x07\x0f\x50\xa8\x2b"
+			  "\xa8\xf1\xfe\x7e\xf4\xf0\x47\xcd"
+			  "\xfd\x91\x78\xf9\x14\x8b\x7d\x27"
+			  "\x0e\xdc\xca\xe6\xf4\xfc\xd7\x4f"
+			  "\x19\x8c\xd0\xe6\x9e\x2f\xf8\x75"
+			  "\xb5\xe2\x48\x00\x4f\x07\xd9\xa1"
+			  "\x42\xbc\x9d\xfc\x17\x98\x00\x48",
+		.klen   = 64,
+		.iv     = "\xcb\x35\x47\x5a\x7a\x06\x28\xb9"
+			  "\x80\xf5\xa7\xe6\x8a\x23\x42\xf8",
+		.ptext	= "\x04\x52\xc8\x7f\xb0\x5a\x12\xc5"
+			  "\x96\x47\x6b\xf4\xbc\x2e\xdb\x74"
+			  "\xd2\x20\x24\x32\xe5\x84\xb6\x25"
+			  "\x4c\x2f\x96\xc7\x55\x9c\x90\x6f"
+			  "\x0e\x96\x94\x68\xf4",
+		.ctext	= "\x6a\x2d\x57\xb8\x72\x49\x10\x6b"
+			  "\x5b\x5a\xc9\x92\xab\x59\x79\x36"
+			  "\x7a\x01\x95\xf7\xdd\xcb\x3f\xbf"
+			  "\xb2\xe3\x7e\x35\xe3\x11\x04\x68"
+			  "\x28\xc3\x70\x6a\xe1",
+		.len	= 37,
+	}, { /* 3 blocks + 22 bytes */
+		.key    = "\xf7\x87\x75\xdf\x36\x20\xe7\xcb"
+			  "\x20\x5d\x49\x96\x81\x3d\x1d\x80"
+			  "\xc7\x18\x7e\xbf\x2a\x0f\x79\xba"
+			  "\x06\xb5\x4b\x63\x03\xfb\xb8\x49"
+			  "\x93\x2d\x85\x5b\x95\x1f\x78\xea"
+			  "\x7c\x1e\xf5\x5d\x02\xc6\xec\xb0"
+			  "\xf0\xaa\x3d\x0a\x04\xe1\x67\x80"
+			  "\x2a\xbe\x4e\x73\xc9\x11\xcc\x6c",
+		.klen   = 64,
+		.iv     = "\xeb\xba\x55\x24\xfc\x8f\x25\x7c"
+			  "\x66\xf9\x04\x03\xcc\xb1\xf4\x84",
+		.ptext	= "\x40\x75\x1b\x72\x2a\xc8\xbf\xef"
+			  "\x0c\x92\x3e\x19\xc5\x09\x07\x38"
+			  "\x4d\x87\x5c\xb8\xd6\x4f\x1a\x39"
+			  "\x8c\xee\xa5\x22\x41\x12\xe1\x22"
+			  "\xb5\x4b\xd7\xeb\x02\xfa\xaa\xf8"
+			  "\x94\x47\x04\x5d\x8a\xb5\x40\x12"
+			  "\x04\x62\x3d\xe4\x19\x8a\xeb\xb3"
+			  "\xf9\xa3\x7d\xb6\xeb\x57\xf9\xb8"
+			  "\x7f\xa8\xfa\x2d\x75\x2d",
+		.ctext	= "\x46\x6d\xe5\x35\x5d\x22\x42\x33"
+			  "\xf7\xb8\xfb\xc0\xcb\x18\xad\xa4"
+			  "\x75\x6c\xc6\x38\xbb\xd4\xa1\x32"
+			  "\x00\x05\x06\xd9\xc9\x17\xd9\x4f"
+			  "\x1a\xf6\x24\x64\x27\x8a\x4a\xad"
+			  "\x88\xa0\x86\xb7\xf9\x33\xaf\xa8"
+			  "\x0e\x83\xd8\x0e\x88\xa2\x81\x79"
+			  "\x65\x2e\x3e\x84\xaf\xa1\x46\x7d"
+			  "\xa9\x91\xf8\x17\x82\x8d",
+		.len	= 70,
+	}, { /* 4 blocks + 23 bytes */
+		.key    = "\x48\x09\xab\x48\xd6\xca\x7d\xb1"
+			  "\x90\xa0\x00\xd8\x33\x8a\x20\x79"
+			  "\x7c\xbc\x0c\x0c\x5f\x41\xbc\xbc"
+			  "\x82\xaf\x41\x81\x23\x93\xcb\xc7"
+			  "\x61\x7b\x83\x13\x16\xb1\x3e\x7c"
+			  "\xcc\xae\xda\xca\x78\xc7\xab\x18"
+			  "\x69\xb6\x58\x3e\x5c\x19\x5f\xed"
+			  "\x7b\xcf\x70\xb9\x76\x00\xd8\xc9",
+		.klen   = 64,
+		.iv     = "\x2e\x20\x36\xf4\xa3\x22\x5d\xd8"
+			  "\x38\x49\x82\xbf\x6c\x56\xd9\x3b",
+		.ptext	= "\x79\x3c\x73\x99\x65\x21\xe1\xb9"
+			  "\xa0\xfd\x22\xb2\x57\xc0\x7f\xf4"
+			  "\x7f\x97\x36\xaf\xf8\x8d\x73\xe1"
+			  "\x0d\x85\xe9\xd5\x3d\x82\xb3\x49"
+			  "\x89\x25\x30\x1f\x0d\xca\x5c\x95"
+			  "\x64\x31\x02\x17\x11\x08\x8f\x32"
+			  "\xbc\x37\x23\x4f\x03\x98\x91\x4a"
+			  "\x50\xe2\x58\xa8\x9b\x64\x09\xe0"
+			  "\xce\x99\xc9\xb0\xa8\x21\x73\xb7"
+			  "\x2d\x4b\x19\xba\x81\x83\x99\xce"
+			  "\xa0\x7a\xd0\x9f\x27\xf6\x8a",
+		.ctext	= "\xf9\x12\x76\x21\x06\x1e\xe4\x4b"
+			  "\xf9\x94\x38\x29\x0f\xee\xcb\x13"
+			  "\xa3\xc3\x50\xe3\xc6\x29\x9d\xcf"
+			  "\x6f\x6a\x0a\x25\xab\x44\xf6\xe4"
+			  "\x71\x29\x75\x3b\x07\x1c\xfc\x1a"
+			  "\x75\xd4\x84\x58\x7f\xc4\xf3\xf7"
+			  "\x8f\x7c\x7a\xdc\xa2\xa3\x95\x38"
+			  "\x15\xdf\x3b\x9c\xdd\x24\xb4\x0b"
+			  "\xa8\x97\xfa\x5f\xee\x58\x00\x0d"
+			  "\x23\xc9\x8d\xee\xc2\x3f\x27\xd8"
+			  "\xd4\x43\xa5\xf8\x25\x71\x3f",
+		.len	= 87,
+	}, { /* 5 blocks + 24 bytes */
+		.key    = "\x8c\xf4\x4c\xe5\x91\x8f\x72\xe9"
+			  "\x2f\xf8\xc0\x3c\x87\x76\x16\xa4"
+			  "\x20\xab\x66\x39\x34\x10\xd6\x91"
+			  "\xf1\x99\x2c\xf1\xd6\xc3\xda\x38"
+			  "\xed\x2a\x4c\x80\xf4\xa5\x56\x28"
+			  "\x1a\x1c\x79\x72\x6c\x93\x08\x86"
+			  "\x8f\x8a\xaa\xcd\xf1\x8c\xca\xe7"
+			  "\x0a\xe8\xee\x0c\x1c\xc2\xa8\xea",
+		.klen   = 64,
+		.iv     = "\x9a\x9e\xbc\xe4\xc9\xf3\xef\x9f"
+			  "\xff\x82\x0e\x22\x8f\x80\x42\x76",
+		.ptext	= "\xc1\xde\x66\x1a\x7e\x60\xd3\x3b"
+			  "\x66\xd6\x29\x86\x99\xc6\xd7\xc8"
+			  "\x29\xbf\x00\x57\xab\x21\x06\x24"
+			  "\xd0\x92\xef\xe6\xb5\x1e\x20\xb9"
+			  "\xb7\x7b\xd7\x18\x88\xf8\xd7\xe3"
+			  "\x90\x61\xcd\x73\x2b\xa1\xb5\xc7"
+			  "\x33\xef\xb5\xf2\x45\xf6\x92\x53"
+			  "\x91\x98\xf8\x5a\x20\x75\x4c\xa8"
+			  "\xf1\xf6\x01\x26\xbc\xba\x4c\xac"
+			  "\xcb\xc2\x6d\xb6\x2c\x3c\x38\x61"
+			  "\xe3\x98\x7f\x3e\x98\xbd\xec\xce"
+			  "\xc0\xb5\x74\x23\x43\x24\x7b\x7e"
+			  "\x3f\xed\xcb\xda\x88\x67\x6f\x9a",
+		.ctext	= "\xeb\xdc\x6a\xb7\xd9\x5f\xa7\xfc"
+			  "\x48\x75\x10\xef\xca\x65\xdc\x88"
+			  "\xd0\x23\xde\x17\x5f\x3b\x61\xa2"
+			  "\x15\x13\x81\x81\xf8\x57\x8b\x2a"
+			  "\xe2\xc8\x49\xd1\xba\xed\xd6\xcb"
+			  "\xed\x6f\x26\x69\x9b\xd2\xd2\x91"
+			  "\x4e\xd7\x81\x20\x66\x38\x0c\x62"
+			  "\x60\xcd\x01\x36\x97\x22\xf0\x5c"
+			  "\xcf\x53\xc6\x58\xf5\x8b\x48\x0c"
+			  "\xa5\x50\xc2\x73\xf9\x70\x60\x09"
+			  "\x22\x69\xf3\x71\x74\x5d\xc9\xa0"
+			  "\x9c\x79\xf9\xc4\x87\xac\xd7\x4b"
+			  "\xac\x3c\xc6\xda\x81\x7a\xdd\x14",
+		.len	= 104,
+	}, { /* 8 blocks + 25 bytes */
+		.key    = "\x70\x18\x09\x93\x10\x3a\x0c\xa9"
+			  "\x02\x0b\x11\x10\xae\x34\x98\xdb"
+			  "\x10\xb5\xee\x8c\x49\xbc\x52\x8e"
+			  "\x4b\xf7\x0a\x36\x16\x8a\xf7\x06"
+			  "\xb5\x94\x52\x54\xb9\xc1\x4d\x20"
+			  "\xa2\xf0\x6e\x19\x7f\x67\x1e\xaa"
+			  "\x94\x6c\xee\x54\x19\xfc\x96\x95"
+			  "\x04\x85\x00\x53\x7c\x39\x5f\xeb",
+		.klen   = 64,
+		.iv     = "\x36\x87\x8f\x9d\x74\xe9\x52\xfb"
+			  "\xe1\x76\x16\x99\x61\x86\xec\x8f",
+		.ptext	= "\x95\x08\xee\xfe\x87\xb2\x4f\x93"
+			  "\x01\xee\xf3\x77\x0d\xbb\xfb\x26"
+			  "\x3e\xb3\x34\x20\xee\x51\xd6\x40"
+			  "\xb1\x64\xae\xd9\xfd\x71\x8f\x93"
+			  "\xa5\x85\xff\x74\xcc\xd3\xfd\x5e"
+			  "\xc2\xfc\x49\xda\xa8\x3a\x94\x29"
+			  "\xa2\x59\x90\x34\x26\xbb\xa0\x34"
+			  "\x5d\x47\x33\xf2\xa8\x77\x90\x98"
+			  "\x8d\xfd\x38\x60\x23\x1e\x50\xa1"
+			  "\x67\x4d\x8d\x09\xe0\x7d\x30\xe3"
+			  "\xdd\x39\x91\xd4\x70\x68\xbb\x06"
+			  "\x4e\x11\xb2\x26\x0a\x85\x73\xf6"
+			  "\x37\xb6\x15\xd0\x77\xee\x43\x7b"
+			  "\x77\x13\xe9\xb9\x84\x2b\x34\xab"
+			  "\x49\xc1\x27\x91\x2e\xa3\xca\xe5"
+			  "\xa7\x79\x45\xba\x36\x97\x49\x44"
+			  "\xf7\x57\x9b\xd7\xac\xb3\xfd\x6a"
+			  "\x1c\xd1\xfc\x1c\xdf\x6f\x94\xac"
+			  "\x95\xf4\x50\x7a\xc8\xc3\x8c\x60"
+			  "\x3c",
+		.ctext	= "\xb6\xc8\xf9\x5d\x35\x5a\x0a\x33"
+			  "\x2b\xd3\x5a\x18\x09\x1c\x1b\x0b"
+			  "\x2a\x0e\xde\xf6\x0d\x04\xa6\xb3"
+			  "\xa8\xe8\x1b\x86\x29\x58\x75\x56"
+			  "\xab\xab\xbf\xbe\x1f\xb4\xc4\xf3"
+			  "\xde\x1a\xb0\x87\x69\xac\x5b\x0c"
+			  "\x1b\xb7\xc7\x24\xa4\x47\xe7\x81"
+			  "\x2c\x0a\x82\xf9\x18\x5d\xe6\x09"
+			  "\xe3\x65\x36\x54\x3d\x8a\x3a\x64"
+			  "\x34\xf4\x34\x7f\x26\x3c\x1e\x3b"
+			  "\x5a\x13\xdf\x7f\xa8\x2d\x81\xce"
+			  "\xfa\xad\xd0\xb1\xca\xfa\xc3\x55"
+			  "\x94\xc8\xb8\x16\x7e\xff\x44\x88"
+			  "\xb4\x47\x4b\xfe\xda\x60\x68\x2e"
+			  "\xfc\x70\xb5\xe3\xf3\xe9\x46\x22"
+			  "\x1d\x98\x66\x09\x0f\xed\xbb\x20"
+			  "\x7b\x8c\x2a\xff\x45\x62\xde\x9b"
+			  "\x20\x2e\x6c\xb4\xe4\x26\x03\x72"
+			  "\x8a\xb4\x19\xc9\xb1\xcf\x9d\x86"
+			  "\xa3",
+		.len	= 153,
+	}, { /* 0 blocks + 26 bytes */
+		.key    = "\x5a\x38\x3f\x9c\x0c\x53\x17\x6c"
+			  "\x60\x72\x23\x26\xba\xfe\xa1\xb7"
+			  "\x03\xa8\xfe\xa0\x7c\xff\x78\x4c"
+			  "\x7d\x84\x2f\x24\x84\x77\xec\x6f"
+			  "\x88\xc8\x36\xe2\xcb\x52\x3c\xb4"
+			  "\x39\xac\x37\xfa\x41\x8b\xc4\x59"
+			  "\x24\x03\xe1\x51\xc9\x54\x7d\xb7"
+			  "\xa3\xde\x91\x44\x8d\x16\x97\x22",
+		.klen   = 64,
+		.iv     = "\xfb\x7f\x3d\x60\x26\x0a\x3a\x3d"
+			  "\xa5\xa3\x45\xf2\x24\x67\xfa\x6e",
+		.ptext	= "\xfb\x56\x97\x65\x7c\xd8\x6c\x3c"
+			  "\x5d\xd3\xea\xa6\xa4\x83\xf7\x9d"
+			  "\x9d\x89\x2c\x85\xb8\xd9\xd4\xf0"
+			  "\x1a\xad",
+		.ctext	= "\xc9\x9b\x4b\xf2\xf7\x0f\x23\xfe"
+			  "\xc3\x93\x88\xa1\xb3\x88\xab\xd6"
+			  "\x26\x78\x82\xa6\x6b\x0b\x76\xad"
+			  "\x21\x5e",
+		.len	= 26,
+	}, { /* 0 blocks + 27 bytes */
+		.key    = "\xc0\xcf\x57\xa2\x3c\xa2\x4b\xf6"
+			  "\x5d\x36\x7b\xd7\x1d\x16\xc3\x2f"
+			  "\x50\xc6\x0a\xb2\xfd\xe8\x24\xfc"
+			  "\x33\xcf\x73\xfd\xe0\xe9\xa5\xd1"
+			  "\x98\xfc\xd6\x16\xdd\xfd\x6d\xab"
+			  "\x44\xbc\x37\x9d\xab\x5b\x1d\xf2"
+			  "\x6f\x5d\xbe\x6b\x14\x14\xc7\x74"
+			  "\xbb\x91\x24\x4b\x52\xcb\x78\x31",
+		.klen   = 64,
+		.iv     = "\x5c\xc1\x3d\xb6\xa1\x6a\x2d\x1f"
+			  "\xee\x75\x19\x4b\x04\xfa\xe1\x7e",
+		.ptext	= "\x02\x95\x3a\xab\xac\x3b\xcd\xcd"
+			  "\x63\xc7\x4c\x7c\xe5\x75\xee\x03"
+			  "\x94\xc7\xff\xe8\xe0\xe9\x86\x2a"
+			  "\xd3\xc7\xe4",
+		.ctext	= "\x8e\x84\x76\x8b\xc1\x47\x55\x15"
+			  "\x5e\x51\xb3\xe2\x3f\x72\x4d\x20"
+			  "\x09\x3f\x4f\xb1\xce\xf4\xb0\x14"
+			  "\xf6\xa7\xb3",
+		.len	= 27,
+	}, { /* 0 blocks + 28 bytes */
+		.key    = "\x0b\x5b\x1d\xc8\xb1\x3f\x8f\xcd"
+			  "\x87\xd2\x58\x28\x36\xc6\x34\xfb"
+			  "\x04\xe8\xf1\xb7\x91\x30\xda\x75"
+			  "\x66\x4a\x72\x90\x09\x39\x02\x19"
+			  "\x62\x2d\xe9\x24\x95\x0e\x87\x43"
+			  "\x4c\xc7\x96\xe4\xc9\x31\x6a\x13"
+			  "\x16\x10\xef\x34\x9b\x98\x19\xf1"
+			  "\x8b\x14\x38\x3f\xf8\x75\xcc\x76",
+		.klen   = 64,
+		.iv     = "\x0c\x2c\x55\x2c\xda\x40\xe1\xab"
+			  "\xa6\x34\x66\x7a\xa4\xa3\xda\x90",
+		.ptext	= "\xbe\x84\xd3\xfe\xe6\xb4\x29\x67"
+			  "\xfd\x29\x78\x41\x3d\xe9\x81\x4e"
+			  "\x3c\xf9\xf4\xf5\x3f\xd8\x0e\xcd"
+			  "\x63\x73\x65\xf3",
+		.ctext	= "\xd0\xa0\x16\x5f\xf9\x85\xd0\x63"
+			  "\x9b\x81\xa1\x15\x93\xb3\x62\x36"
+			  "\xec\x93\x0e\x14\x07\xf2\xa9\x38"
+			  "\x80\x33\xc0\x20",
+		.len	= 28,
+	}, { /* 0 blocks + 29 bytes */
+		.key    = "\xdc\x4c\xdc\x20\xb1\x34\x89\xa4"
+			  "\xd0\xb6\x77\x05\xea\x0c\xcc\x68"
+			  "\xb1\xd6\xf7\xfd\xa7\x0a\x5b\x81"
+			  "\x2d\x4d\xa3\x65\xd0\xab\xa1\x02"
+			  "\x85\x4b\x33\xea\x51\x16\x50\x12"
+			  "\x3b\x25\xba\x13\xba\x7c\xbb\x3a"
+			  "\xe4\xfd\xb3\x9c\x88\x8b\xb8\x30"
+			  "\x7a\x97\xcf\x95\x5d\x69\x7b\x1d",
+		.klen   = 64,
+		.iv     = "\xe7\x69\xed\xd2\x54\x5d\x4a\x29"
+			  "\xb2\xd7\x60\x90\xa0\x0b\x0d\x3a",
+		.ptext	= "\x37\x22\x11\x62\xa0\x74\x92\x62"
+			  "\x40\x4e\x2b\x0a\x8b\xab\xd8\x28"
+			  "\x8a\xd2\xeb\xa5\x8e\xe1\x42\xc8"
+			  "\x49\xef\x9a\xec\x1b",
+		.ctext	= "\x7c\x66\x72\x6b\xe3\xc3\x57\x71"
+			  "\x37\x13\xce\x1f\x6b\xff\x13\x87"
+			  "\x65\xa7\xa1\xc5\x23\x7f\xca\x40"
+			  "\x82\xbf\x2f\xc0\x2a",
+		.len	= 29,
+	}, { /* 0 blocks + 30 bytes */
+		.key    = "\x72\x9a\xf5\x53\x55\xdd\x0f\xef"
+			  "\xfc\x75\x6f\x03\x88\xc8\xba\x88"
+			  "\xb7\x65\x89\x5d\x03\x86\x21\x22"
+			  "\xb8\x42\x87\xd9\xa9\x83\x9e\x9c"
+			  "\xca\x28\xa1\xd2\xb6\xd0\xa6\x6c"
+			  "\xf8\x57\x42\x7c\x73\xfc\x7b\x0a"
+			  "\xbc\x3c\x57\x7b\x5a\x39\x61\x55"
+			  "\xb7\x25\xe9\xf1\xc4\xbb\x04\x28",
+		.klen   = 64,
+		.iv     = "\x8a\x38\x22\xba\xea\x5e\x1d\xa4"
+			  "\x31\x18\x12\x5c\x56\x0c\x12\x50",
+		.ptext	= "\x06\xfd\xbb\xa9\x2e\x56\x05\x5f"
+			  "\xf2\xa7\x36\x76\x26\xd3\xb3\x49"
+			  "\x7c\xe2\xe3\xbe\x1f\x65\xd2\x17"
+			  "\x65\xe2\xb3\x0e\xb1\x93",
+		.ctext	= "\xae\x1f\x19\x7e\x3b\xb3\x65\xcb"
+			  "\x14\x70\x6b\x3c\xa0\x63\x95\x94"
+			  "\x56\x52\xe1\xb4\x14\xca\x21\x13"
+			  "\xb5\x03\x3f\xfe\xc9\x9f",
+		.len	= 30,
+	}, { /* 0 blocks + 31 bytes */
+		.key    = "\xce\x06\x45\x53\x25\x81\xd2\xb2"
+			  "\xdd\xc9\x57\xfe\xbb\xf6\x83\x07"
+			  "\x28\xd8\x2a\xff\x53\xf8\x57\xc6"
+			  "\x63\x50\xd4\x3e\x2a\x54\x37\x51"
+			  "\x07\x3b\x23\x63\x3c\x31\x57\x0d"
+			  "\xd3\x59\x20\xf2\xd0\x85\xac\xc5"
+			  "\x3f\xa1\x74\x90\x0a\x3f\xf4\x10"
+			  "\x12\xf0\x1b\x2b\xef\xcb\x86\x74",
+		.klen   = 64,
+		.iv     = "\x6d\x3e\x62\x94\x75\x43\x74\xea"
+			  "\xed\x4a\xa6\xde\xba\x55\x83\x38",
+		.ptext	= "\x6a\xe6\xa3\x66\x7e\x78\xef\x42"
+			  "\x8b\x28\x08\x24\xda\xd4\xd6\x42"
+			  "\x3d\xb6\x48\x7e\x51\xa6\x92\x65"
+			  "\x98\x86\x26\x98\x37\x42\xa5",
+		.ctext	= "\x64\xc6\xfc\x60\x21\x87\x7a\xf5"
+			  "\xc3\x1d\xba\x41\x3c\x9c\x8c\xe8"
+			  "\x2d\x93\xf0\x02\x95\x6d\xfe\x8d"
+			  "\x68\x17\x05\x75\xc0\xd3\xa8",
+		.len	= 31,
 	}
 };
 
-- 
2.17.1

