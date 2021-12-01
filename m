Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCE846442E
	for <lists+linux-crypto@lfdr.de>; Wed,  1 Dec 2021 01:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346095AbhLAAxn (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 30 Nov 2021 19:53:43 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:46084 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345925AbhLAAwy (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 30 Nov 2021 19:52:54 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 321C6218A9;
        Wed,  1 Dec 2021 00:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638319773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lwDDJCMkewlQh8HvM69kHIh3hIG8ypHVy0WU3YlLy7o=;
        b=Yz+0Fq1tNfwGSvpyaQNF9IZDNp4J4iUmmk1xxssP0mmzDRUpnOtAoRk1DdwY94Jd5f5Pw2
        400HbTCJz25pRpFxrsR78gBN06rNzRsW4WqvmBp4FNdGpAuCbKBdE9Dp9wEGyio1O0xIJn
        kN2/+uATVEWHG5q62z7VJJOu5UaLpTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638319773;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lwDDJCMkewlQh8HvM69kHIh3hIG8ypHVy0WU3YlLy7o=;
        b=LNTxGtqnYPEMvZJiayTt6Ezcr3gXcZyj7MTeROQfREOfyxW0RBWTBMuouI5K+pmXp2F+CF
        QC9b3eSZnAwzt0CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D0CF13C10;
        Wed,  1 Dec 2021 00:49:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3tDHBZ3GpmH+KAAAMHmgww
        (envelope-from <nstange@suse.de>); Wed, 01 Dec 2021 00:49:33 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     =?UTF-8?q?Stephan=20M=C3=BCller?= <smueller@chronox.de>,
        Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.de>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, keyrings@vger.kernel.org,
        Nicolai Stange <nstange@suse.de>
Subject: [PATCH 13/18] crypto: testmgr - add DH test vectors for key generation
Date:   Wed,  1 Dec 2021 01:48:53 +0100
Message-Id: <20211201004858.19831-14-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211201004858.19831-1-nstange@suse.de>
References: <20211201004858.19831-1-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Now that all DH implementations support ephemeral key generation triggered
by passing a ->key_size of zero to ->set_secret(), it's certainly
worthwhile to build upon the testmgr's do_test_kpp() ->genkey facility to
test it.

Add two ->genkey DH test vectors to the testmgr, one for the RFC 7919
ffdhe2048 group and another one for the RFC 3526 modp2048 group.

All required values have been generated with OpenSSL.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 crypto/testmgr.h | 148 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 148 insertions(+)

diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index b295512c8f22..074e5de84a6e 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -1331,6 +1331,80 @@ static const struct kpp_testvec dh_tv_template[] = {
 	.expected_a_public_size = 256,
 	.expected_ss_size = 256,
 	},
+	{
+	.secret =
+#ifdef __LITTLE_ENDIAN
+	"\x01\x00" /* type */
+	"\x14\x00" /* len */
+	"\x01\x00\x00\x00" /* group_id == dh_group_id_rfc7919_ffdhe2048 */
+	"\x00\x00\x00\x00" /* key_size */
+	"\x00\x00\x00\x00" /* p_size */
+	"\x00\x00\x00\x00", /* g_size */
+#else
+	"\x00\x01" /* type */
+	"\x00\x14" /* len */
+	"\x00\x00\x00\x01" /* group_id == dh_group_id_rfc7919_ffdhe2048 */
+	"\x00\x00\x00\x00" /* key_size */
+	"\x00\x00\x00\x00" /* p_size */
+	"\x00\x00\x00\x00", /* g_size */
+#endif
+	.b_secret =
+#ifdef __LITTLE_ENDIAN
+	"\x01\x00" /* type */
+	"\x14\x01" /* len */
+	"\x01\x00\x00\x00" /* group_id == dh_group_id_rfc7919_ffdhe2048 */
+	"\x00\x01\x00\x00" /* key_size */
+	"\x00\x00\x00\x00" /* p_size */
+	"\x00\x00\x00\x00" /* g_size */
+#else
+	"\x00\x01" /* type */
+	"\x01\x14" /* len */
+	"\x00\x00\x00\x01" /* group_id == dh_group_id_rfc7919_ffdhe2048 */
+	"\x00\x00\x01\x00" /* key_size */
+	"\x00\x00\x00\x00" /* p_size */
+	"\x00\x00\x00\x00" /* g_size */
+#endif
+	/* xa */
+	"\x1c\x47\xb9\xb9\xe7\x67\x05\x0a\x67\xee\xd2\x4e\xb2\x91\x60\xff"
+	"\xe4\x3e\xe0\x32\xf0\x74\x2b\xaa\x97\x90\xdb\x2d\x1c\x82\x0b\xa9"
+	"\x2b\x9b\x2a\x6a\xe6\xb3\xf5\xa7\xd0\x86\x4f\x0f\xca\x7f\x1c\xfc"
+	"\x36\xf3\x77\xe2\xca\x6e\x20\x3f\x80\x9c\x37\x08\x57\x11\x2d\xbd"
+	"\xb3\x86\xd6\x5f\xa4\xd6\x03\xab\x99\x47\x9f\xe4\x06\x80\xad\x5a"
+	"\x88\x5e\x48\x1d\xd3\x15\x73\xc3\xa3\x2c\xa6\x87\xc3\x53\xca\x65"
+	"\x60\xf8\xcf\xcc\xf1\x17\xa8\x7e\xd4\x71\x77\x7a\x04\x1c\x69\x86"
+	"\x7c\xc9\x7a\x49\xe0\x0c\x5c\x36\xdf\x99\x6c\xd4\xed\xae\x51\x6c"
+	"\xb7\x1d\x29\xb2\xb8\x61\xd1\x4a\x6e\x01\x3c\xc1\xae\x05\x75\xf0"
+	"\xf6\x34\xb2\x09\x18\x38\x3d\xf5\x86\x32\x3d\xf9\xe9\xb2\x80\xc1"
+	"\x95\xb6\x28\xfd\xb6\xc5\xdb\x7a\xf5\x0a\x2c\xc9\x48\xb1\xba\x56"
+	"\x24\x1c\xfc\x6b\x44\x33\x64\x21\x06\x10\x28\x24\xe7\xe8\xa6\xf2"
+	"\x27\xe6\x2a\x7b\xd1\x69\xa4\x2f\x89\xa6\xc9\xce\x3c\x32\x4a\x2d"
+	"\x57\x22\x1b\xbc\x98\x66\x3a\x05\xad\x39\x5a\xb5\x94\xbc\xd8\x8d"
+	"\xe4\x0f\xbc\x39\xe7\xba\xf7\x1b\x0c\x7c\x2d\xae\x7b\x67\xa3\x48"
+	"\xfe\xe7\xef\x98\x15\x52\xe9\xb1\x7c\x1c\x6a\x7e\x3c\x87\xd5\xe7",
+	.b_public =
+	"\x5c\x00\x6f\xda\xfe\x4c\x0c\xc2\x18\xff\xa9\xec\x7a\xbe\x8a\x51"
+	"\x64\x6b\x57\xf8\xed\xe2\x36\x77\xc1\x23\xbf\x56\xa6\x48\x76\x34"
+	"\x0e\xf3\x68\x05\x45\x6a\x98\x5b\x9e\x8b\xc0\x11\x29\xcb\x5b\x66"
+	"\x2d\xc2\xeb\x4c\xf1\x7d\x85\x30\xaa\xd5\xf5\xb8\xd3\x62\x1e\x97"
+	"\x1e\x34\x18\xf8\x76\x8c\x10\xca\x1f\xe4\x5d\x62\xe1\xbe\x61\xef"
+	"\xaf\x2c\x8d\x97\x15\xa5\x86\xd5\xd3\x12\x6f\xec\xe2\xa4\xb2\x5a"
+	"\x35\x1d\xd4\x91\xa6\xef\x13\x09\x65\x9c\x45\xc0\x12\xad\x7f\xee"
+	"\x93\x5d\xfa\x89\x26\x7d\xae\xee\xea\x8c\xa3\xcf\x04\x2d\xa0\xc7"
+	"\xd9\x14\x62\xaf\xdf\xa0\x33\xd7\x5e\x83\xa2\xe6\x0e\x0e\x5d\x77"
+	"\xce\xe6\x72\xe4\xec\x9d\xff\x72\x9f\x38\x95\x19\x96\xba\x4c\xe3"
+	"\x5f\xb8\x46\x4a\x1d\xe9\x62\x7b\xa8\xdc\xe7\x61\x90\x6b\xb9\xd4"
+	"\xad\x0b\xa3\x06\xb3\x70\xfa\xea\x2b\xc4\x2c\xde\x43\x37\xf6\x8d"
+	"\x72\xf0\x86\x9a\xbb\x3b\x8e\x7a\x71\x03\x30\x30\x2a\x5d\xcd\x1e"
+	"\xe4\xd3\x08\x07\x75\x17\x17\x72\x1e\x77\x6c\x98\x0d\x29\x7f\xac"
+	"\xe7\xb2\xee\xa9\x1c\x33\x9d\x08\x39\xe1\xd8\x5b\xe5\xbc\x48\xb2"
+	"\xb6\xdf\xcd\xa0\x42\x06\xcc\xfb\xed\x60\x6f\xbc\x57\xac\x09\x45",
+	.secret_size = 20,
+	.b_secret_size = 276,
+	.b_public_size = 256,
+	.expected_a_public_size = 256,
+	.expected_ss_size = 256,
+	.genkey = true,
+	},
 #elif IS_ENABLED(CONFIG_CRYPTO_DH_GROUPS_RFC3526)
 	{
 	.secret =
@@ -1422,6 +1496,80 @@ static const struct kpp_testvec dh_tv_template[] = {
 	.expected_a_public_size = 256,
 	.expected_ss_size = 256,
 	},
+	{
+	.secret =
+#ifdef __LITTLE_ENDIAN
+	"\x01\x00" /* type */
+	"\x14\x00" /* len */
+	"\x06\x00\x00\x00" /* group_id == dh_group_id_rfc3526_modp2048 */
+	"\x00\x00\x00\x00" /* key_size */
+	"\x00\x00\x00\x00" /* p_size */
+	"\x00\x00\x00\x00", /* g_size */
+#else
+	"\x00\x01" /* type */
+	"\x00\x14" /* len */
+	"\x00\x00\x00\x06" /* group_id == dh_group_id_rfc3526_modp2048 */
+	"\x00\x00\x00\x00" /* key_size */
+	"\x00\x00\x00\x00" /* p_size */
+	"\x00\x00\x00\x00", /* g_size */
+#endif
+	.b_secret =
+#ifdef __LITTLE_ENDIAN
+	"\x01\x00" /* type */
+	"\x14\x01" /* len */
+	"\x06\x00\x00\x00" /* group_id == dh_group_id_rfc3526_modp2048 */
+	"\x00\x01\x00\x00" /* key_size */
+	"\x00\x00\x00\x00" /* p_size */
+	"\x00\x00\x00\x00" /* g_size */
+#else
+	"\x00\x01" /* type */
+	"\x01\x14" /* len */
+	"\x00\x00\x00\x06" /* group_id == dh_group_id_rfc3526_modp2048 */
+	"\x00\x00\x01\x00" /* key_size */
+	"\x00\x00\x00\x00" /* p_size */
+	"\x00\x00\x00\x00" /* g_size */
+#endif
+	/* xa */
+	"\x52\xef\x50\xb5\x79\xa6\x02\xbb\x19\x43\x9d\x67\xcc\xc9\x8e\x02"
+	"\x30\x13\xe0\x29\x38\x64\x2e\x57\x10\xbe\xcb\x79\x19\xf2\x45\xc5"
+	"\xd8\x31\x91\x11\x93\x81\xd6\xfa\x11\x03\xc7\xf4\x21\xe6\x6c\x7a"
+	"\xa8\x16\x0c\x13\xda\x14\x69\x52\xaa\xd7\x2a\xee\xa5\xa8\x51\x12"
+	"\x6c\x75\x84\x01\x96\xd7\x57\xec\xb6\x7c\x33\xb2\xd4\xb9\x42\x95"
+	"\xdd\x32\x9a\x09\xfd\x96\x12\x38\xe6\x97\x20\xfa\xba\x10\x5c\x9d"
+	"\xb3\x26\xfb\x93\x33\xc6\x5d\xc2\x1f\x73\x1b\x60\x01\xc6\xc9\x31"
+	"\xc1\x97\xec\x72\x68\x07\xb3\x80\x3a\xbb\xe8\xdd\x58\x32\x53\x06"
+	"\x08\xba\xc0\x0e\x8d\xfc\x54\xb8\x50\x30\xc0\x8b\xfe\xdc\xaa\xe9"
+	"\xe2\x0e\x22\x7b\x4b\x8a\xcc\x2b\xdb\xf2\x47\x1e\x62\xc7\xc1\xba"
+	"\x32\x2e\xec\xb2\xf6\xfa\xa5\xce\x45\xe2\x9e\x9a\xde\x7c\x4a\x6b"
+	"\x75\x45\x91\xe3\x6e\x33\xa5\xa7\x1d\x3a\xd2\x60\x65\xad\x58\xeb"
+	"\x9b\x90\x72\x3b\x0f\xfd\xef\x42\xfd\x1e\x16\x2b\xa1\x8c\xa5\xd9"
+	"\x85\xf6\x2c\xab\x5a\x0c\x68\x64\x6a\xce\xc1\x15\x88\x32\x47\x41"
+	"\x51\x0f\x8e\x37\x72\xf8\x7a\x13\x41\x54\xa9\x02\x1b\x8e\x0d\xb2"
+	"\x7c\xee\xf8\x60\x7e\xb1\x86\xed\x7d\xa1\xca\xf1\xd4\xbc\x81\xd8",
+	.b_public =
+	"\x75\x98\x23\x19\xc9\xc2\xe1\x59\x73\xc2\x1d\xc5\x2c\xad\x22\x90"
+	"\xa8\xa4\xb4\xfa\xd7\x67\x5b\xe9\xa1\x0e\x15\x3b\x5d\xae\xd3\x25"
+	"\x29\xfc\x26\x79\xd6\x86\xf2\x21\x20\x86\xd7\x17\xce\xe7\x6a\x74"
+	"\x3e\x2e\x8b\x62\x87\x62\xe9\x27\xc0\x57\xca\x5b\xaf\x86\x22\xd6"
+	"\xdd\xf6\x88\xd2\x86\x21\xf7\x39\x6a\x3f\x52\x17\x03\xdc\xb9\x44"
+	"\x03\xdf\xb5\x6e\x5d\x15\x50\x6f\xf8\x9a\x3c\xee\x9f\xc5\x01\x23"
+	"\xd8\x2d\xb8\x18\x37\xc8\xed\x7d\x46\x27\x03\xc9\xae\x3b\xbf\x9e"
+	"\x4e\x98\x91\x30\x56\xcb\x09\x6b\x8e\xd3\xe5\x87\xfe\x82\x66\x36"
+	"\x2c\xee\x88\x74\x00\x8a\x2d\x36\x39\x2b\xe7\xbd\x18\x21\x36\xd0"
+	"\x98\x34\x6c\xb1\x4f\xbf\xd0\x0c\xd3\x6c\x64\x2e\x04\xfa\x68\x13"
+	"\x51\xaf\x1b\xc8\xc3\xbd\x13\x44\x72\x89\xd5\xa3\xd8\x83\x22\xf1"
+	"\x92\xeb\x5a\x70\x5e\x91\x1e\x86\xb9\x2f\x18\x44\x8c\x5a\xe0\x18"
+	"\x6c\x7a\xc6\x20\x27\x27\xae\x6a\x9e\x1b\x9b\xae\x13\xc9\x73\x22"
+	"\x0c\x0d\xdf\x97\x9c\x87\x06\x48\xdc\xe0\x8d\x83\xe1\x32\x8a\x8f"
+	"\x80\x60\x70\x7c\x7e\x10\x10\xf0\xd7\x49\x09\xfc\xf0\x0e\x11\x3f"
+	"\xb4\x5a\x9e\x3d\x38\x28\x3d\x46\x5a\x63\x6c\x9e\x14\xe3\x7c\x13",
+	.secret_size = 20,
+	.b_secret_size = 276,
+	.b_public_size = 256,
+	.expected_a_public_size = 256,
+	.expected_ss_size = 256,
+	.genkey = true,
+	},
 #else
 	{
 	.secret =
-- 
2.26.2

