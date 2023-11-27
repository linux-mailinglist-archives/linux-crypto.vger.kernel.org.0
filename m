Return-Path: <linux-crypto+bounces-292-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD797F985D
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Nov 2023 05:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 908FF1C20410
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Nov 2023 04:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1237DDC3
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Nov 2023 04:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UACw++3V"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F9EEB;
	Sun, 26 Nov 2023 19:35:20 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cfc9c4acb6so3175845ad.0;
        Sun, 26 Nov 2023 19:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701056119; x=1701660919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ssk5Abzwo4ytex3sYQ2U++2wbQ07TVIErdEorqQPuwU=;
        b=UACw++3VZqlc2lLnmKMJOkbTc53MyTURcJuu4/RYYJ+Cx1De3mZqZDHAFAfTsTVn2G
         vgt3eu0z4+oGdh0oc5fPOTw262VmEsCJuFzlyz1mvii3EZP5Mf1Hh0/fAto6U+U/jyZC
         i00sByMlV+9Q5W2aXx0GCodVTGlTsOlj5OtDWMI3K83dswjIY0RaliyGZEw5teyjTT0v
         FR44SP/KCSmDwxMsFR5+jqAcR1lff0wxj8uNo1qUhbm/yI1WWoCf25xDJs0dCfqeKQEf
         HsR5kjDlEYHAay4O6sNYczXDgFbzVyEaGKahccvT9bFO62cv20k1rtISTrGt+1QSY/kP
         EdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701056119; x=1701660919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ssk5Abzwo4ytex3sYQ2U++2wbQ07TVIErdEorqQPuwU=;
        b=kIbS0U7s5IAvbHjsbkbn4yZKx+/jwE3x4g4/k/LEozuK7Bv8kf5GG1xYqo8YAPSeBM
         EvhuP0YNKF8uJLAyyo7CheYO8xrsI8MWQbfy/C18wFb0Q+afW937Ni3Ul+f33Ntm/eqL
         MI0L7nBe87YrNol0/EnyAdlHCEcw8d9eULlwVqC8hHujSnFfDjU9Z1haRqsoRgaQkr+l
         zAlky0bDgS+/NxuhfxtV6zWfKxQ9ruU8JEr6jIgd6xDbEBKT/Hgr90W4nALhjTdFDF8W
         etZWSIzCtuHzVz7iNwMLS2gjdS9yVp7BMtiM5T2nkY3KtaS/NEioiHdfFKFj7TUgT9Iz
         rIig==
X-Gm-Message-State: AOJu0Yw1JHV2eG7bStvyO2ZYpx49CrHVx/X54tzExtGxU6Pfxugtz06a
	DxAHhAVZBSzorTp7dXDgOG7ZLy+zerk=
X-Google-Smtp-Source: AGHT+IG0ZAHM4c3weK45UF0baXzlRNh53yI/FPkX9NZXIpdAVkdKniCV4fQbQ+srFZ4MdD/NEUyCOg==
X-Received: by 2002:a17:903:1250:b0:1cc:5378:6a56 with SMTP id u16-20020a170903125000b001cc53786a56mr11115598plh.48.1701056119572;
        Sun, 26 Nov 2023 19:35:19 -0800 (PST)
Received: from localhost.localdomain ([156.240.117.4])
        by smtp.gmail.com with ESMTPSA id q8-20020a17090311c800b001cf57ea953csm7078684plh.290.2023.11.26.19.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 19:35:19 -0800 (PST)
From: Yusong Gao <a869920004@gmail.com>
To: jarkko@kernel.org,
	davem@davemloft.net,
	dhowells@redhat.com,
	dwmw2@infradead.org,
	juergh@proton.me,
	zohar@linux.ibm.com,
	herbert@gondor.apana.org.au,
	lists@sapience.com,
	dimitri.ledkov@canonical.com
Cc: keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: [PATCH v5] sign-file: Fix incorrect return values check
Date: Mon, 27 Nov 2023 03:34:56 +0000
Message-Id: <20231127033456.452151-1-a869920004@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are some wrong return values check in sign-file when call OpenSSL
API. The ERR() check cond is wrong because of the program only check the
return value is < 0 which ignored the return val is 0. For example:
1. CMS_final() return 1 for success or 0 for failure.
2. i2d_CMS_bio_stream() returns 1 for success or 0 for failure.
3. i2d_TYPEbio() return 1 for success and 0 for failure.
4. BIO_free() return 1 for success and 0 for failure.

Link: https://www.openssl.org/docs/manmaster/man3/
Fixes: e5a2e3c84782 ("scripts/sign-file.c: Add support for signing with a raw signature")
Signed-off-by: Yusong Gao <a869920004@gmail.com>
---
V1, V2: Clarify the description of git message.
V3: Removed redundant empty line.
V4: Change to more strict check mode.
---
 scripts/sign-file.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index 598ef5465f82..3edb156ae52c 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -322,7 +322,7 @@ int main(int argc, char **argv)
 				     CMS_NOSMIMECAP | use_keyid |
 				     use_signed_attrs),
 		    "CMS_add1_signer");
-		ERR(CMS_final(cms, bm, NULL, CMS_NOCERTS | CMS_BINARY) < 0,
+		ERR(CMS_final(cms, bm, NULL, CMS_NOCERTS | CMS_BINARY) != 1,
 		    "CMS_final");
 
 #else
@@ -341,10 +341,10 @@ int main(int argc, char **argv)
 			b = BIO_new_file(sig_file_name, "wb");
 			ERR(!b, "%s", sig_file_name);
 #ifndef USE_PKCS7
-			ERR(i2d_CMS_bio_stream(b, cms, NULL, 0) < 0,
+			ERR(i2d_CMS_bio_stream(b, cms, NULL, 0) != 1,
 			    "%s", sig_file_name);
 #else
-			ERR(i2d_PKCS7_bio(b, pkcs7) < 0,
+			ERR(i2d_PKCS7_bio(b, pkcs7) != 1,
 			    "%s", sig_file_name);
 #endif
 			BIO_free(b);
@@ -374,9 +374,9 @@ int main(int argc, char **argv)
 
 	if (!raw_sig) {
 #ifndef USE_PKCS7
-		ERR(i2d_CMS_bio_stream(bd, cms, NULL, 0) < 0, "%s", dest_name);
+		ERR(i2d_CMS_bio_stream(bd, cms, NULL, 0) != 1, "%s", dest_name);
 #else
-		ERR(i2d_PKCS7_bio(bd, pkcs7) < 0, "%s", dest_name);
+		ERR(i2d_PKCS7_bio(bd, pkcs7) != 1, "%s", dest_name);
 #endif
 	} else {
 		BIO *b;
@@ -396,7 +396,7 @@ int main(int argc, char **argv)
 	ERR(BIO_write(bd, &sig_info, sizeof(sig_info)) < 0, "%s", dest_name);
 	ERR(BIO_write(bd, magic_number, sizeof(magic_number) - 1) < 0, "%s", dest_name);
 
-	ERR(BIO_free(bd) < 0, "%s", dest_name);
+	ERR(BIO_free(bd) != 1, "%s", dest_name);
 
 	/* Finally, if we're signing in place, replace the original. */
 	if (replace_orig)
-- 
2.34.1


