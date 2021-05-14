Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8900B3811B1
	for <lists+linux-crypto@lfdr.de>; Fri, 14 May 2021 22:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbhENUV6 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 14 May 2021 16:21:58 -0400
Received: from mga14.intel.com ([192.55.52.115]:16076 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233202AbhENUVy (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 14 May 2021 16:21:54 -0400
IronPort-SDR: wBpT6zhHoDEOgu30pD3ewKHWN32t0mL4ma7a+jqQOykJk008ex+CNwcg3iBviB4jAcCpHwPF5u
 fWSEXKG3gapA==
X-IronPort-AV: E=McAfee;i="6200,9189,9984"; a="199921597"
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="199921597"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 13:20:37 -0700
IronPort-SDR: IeFs2124po+FNEVQbH2f/r8tF+6C4qmz9uoynzTwnulps3dckFJ22vyb3097JFFy5WPgkBo4dQ
 BHI/EDiijW0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="438147186"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga008.jf.intel.com with ESMTP; 14 May 2021 13:20:37 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     tglx@linutronix.de, mingo@kernel.org, bp@suse.de, luto@kernel.org,
        x86@kernel.org, herbert@gondor.apana.org.au
Cc:     dan.j.williams@intel.com, dave.hansen@intel.com,
        ravi.v.shankar@intel.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, chang.seok.bae@intel.com
Subject: [RFC PATCH v2 08/11] crypto: x86/aes-ni - Improve error handling
Date:   Fri, 14 May 2021 13:15:05 -0700
Message-Id: <20210514201508.27967-9-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210514201508.27967-1-chang.seok.bae@intel.com>
References: <20210514201508.27967-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Some error case in the glue code is possibly ignored and thus not handled
correctly. Make sure each error code is not overwritten.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: x86@kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from RFC v1:
* Added as a new patch. This change prepares to address Ard's feedback.
---
 arch/x86/crypto/aesni-intel_glue.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index 2144e54a6c89..685943f0e5a3 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -291,7 +291,7 @@ static int ecb_encrypt(struct skcipher_request *req)
 			      nbytes & AES_BLOCK_MASK);
 		kernel_fpu_end();
 		nbytes &= AES_BLOCK_SIZE - 1;
-		err = skcipher_walk_done(&walk, nbytes);
+		err |= skcipher_walk_done(&walk, nbytes);
 	}
 
 	return err;
@@ -313,7 +313,7 @@ static int ecb_decrypt(struct skcipher_request *req)
 			      nbytes & AES_BLOCK_MASK);
 		kernel_fpu_end();
 		nbytes &= AES_BLOCK_SIZE - 1;
-		err = skcipher_walk_done(&walk, nbytes);
+		err |= skcipher_walk_done(&walk, nbytes);
 	}
 
 	return err;
@@ -335,7 +335,7 @@ static int cbc_encrypt(struct skcipher_request *req)
 			      nbytes & AES_BLOCK_MASK, walk.iv);
 		kernel_fpu_end();
 		nbytes &= AES_BLOCK_SIZE - 1;
-		err = skcipher_walk_done(&walk, nbytes);
+		err |= skcipher_walk_done(&walk, nbytes);
 	}
 
 	return err;
@@ -357,7 +357,7 @@ static int cbc_decrypt(struct skcipher_request *req)
 			      nbytes & AES_BLOCK_MASK, walk.iv);
 		kernel_fpu_end();
 		nbytes &= AES_BLOCK_SIZE - 1;
-		err = skcipher_walk_done(&walk, nbytes);
+		err |= skcipher_walk_done(&walk, nbytes);
 	}
 
 	return err;
@@ -522,7 +522,7 @@ static int ctr_crypt(struct skcipher_request *req)
 			nbytes = 0;
 		}
 		kernel_fpu_end();
-		err = skcipher_walk_done(&walk, nbytes);
+		err |= skcipher_walk_done(&walk, nbytes);
 	}
 	return err;
 }
@@ -691,7 +691,7 @@ static int gcmaes_crypt_by_sg(bool enc, struct aead_request *req,
 		}
 		kernel_fpu_end();
 
-		err = skcipher_walk_done(&walk, 0);
+		err |= skcipher_walk_done(&walk, 0);
 	}
 
 	if (err)
@@ -862,7 +862,7 @@ static int xts_crypt(struct skcipher_request *req, bool encrypt)
 		skcipher_request_set_crypt(&subreq, req->src, req->dst,
 					   blocks * AES_BLOCK_SIZE, req->iv);
 		req = &subreq;
-		err = skcipher_walk_virt(&walk, req, false);
+		err |= skcipher_walk_virt(&walk, req, false);
 	} else {
 		tail = 0;
 	}
@@ -888,7 +888,7 @@ static int xts_crypt(struct skcipher_request *req, bool encrypt)
 					  nbytes, walk.iv);
 		kernel_fpu_end();
 
-		err = skcipher_walk_done(&walk, walk.nbytes - nbytes);
+		err |= skcipher_walk_done(&walk, walk.nbytes - nbytes);
 
 		if (walk.nbytes > 0)
 			kernel_fpu_begin();
@@ -905,7 +905,7 @@ static int xts_crypt(struct skcipher_request *req, bool encrypt)
 		skcipher_request_set_crypt(req, src, dst, AES_BLOCK_SIZE + tail,
 					   req->iv);
 
-		err = skcipher_walk_virt(&walk, &subreq, false);
+		err |= skcipher_walk_virt(&walk, &subreq, false);
 		if (err)
 			return err;
 
-- 
2.17.1

