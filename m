Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0FE372ED
	for <lists+linux-crypto@lfdr.de>; Thu,  6 Jun 2019 13:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfFFLbi (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 6 Jun 2019 07:31:38 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:26129 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727296AbfFFLbi (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 6 Jun 2019 07:31:38 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45KNlp6rxYzB09ZH;
        Thu,  6 Jun 2019 13:31:34 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=eNckrlJg; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 69r4J1NL1uvP; Thu,  6 Jun 2019 13:31:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45KNlp5gPtzB09ZF;
        Thu,  6 Jun 2019 13:31:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1559820694; bh=EkT6MLTyLoWlWTZ1LfczJS2L/RcVxXFmqO5SUzS0rqg=;
        h=From:Subject:To:Cc:Date:From;
        b=eNckrlJghjx+Jw7II7lbZTuyXhbRw0loJZzikKQx8KBOTwwImbpl1MpNeQS2XcCx+
         R6tUufCdVAXR8PpNXgSFJPUdOsf9d/A3aVKKlcAA3RjLGreggabGkT0r5c5i05CqJA
         QHFTumDge7vpJuXzrxzfnCxJvBjFyjfm363xa3CQ=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 08D088B894;
        Thu,  6 Jun 2019 13:31:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id MwOSCRWVUvK8; Thu,  6 Jun 2019 13:31:35 +0200 (CEST)
Received: from po16838vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B61BA8B891;
        Thu,  6 Jun 2019 13:31:35 +0200 (CEST)
Received: by po16838vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 5623468CFD; Thu,  6 Jun 2019 11:31:35 +0000 (UTC)
Message-Id: <cover.1559819372.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 0/5] Additional fixes on Talitos driver
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, horia.geanta@nxp.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Date:   Thu,  6 Jun 2019 11:31:35 +0000 (UTC)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This series is the last set of fixes for the Talitos driver.

We now get a fully clean boot on both SEC1 (SEC1.2 on mpc885) and
SEC2 (SEC2.2 on mpc8321E) with CONFIG_CRYPTO_MANAGER_EXTRA_TESTS:

[    3.385197] bus: 'platform': really_probe: probing driver talitos with device ff020000.crypto
[    3.450982] random: fast init done
[   12.252548] alg: No test for authenc(hmac(md5),cbc(aes)) (authenc-hmac-md5-cbc-aes-talitos-hsna)
[   12.262226] alg: No test for authenc(hmac(md5),cbc(des3_ede)) (authenc-hmac-md5-cbc-3des-talitos-hsna)
[   43.310737] Bug in SEC1, padding ourself
[   45.603318] random: crng init done
[   54.612333] talitos ff020000.crypto: fsl,sec1.2 algorithms registered in /proc/crypto
[   54.620232] driver: 'talitos': driver_bound: bound to device 'ff020000.crypto'

[    1.193721] bus: 'platform': really_probe: probing driver talitos with device b0030000.crypto
[    1.229197] random: fast init done
[    2.714920] alg: No test for authenc(hmac(sha224),cbc(aes)) (authenc-hmac-sha224-cbc-aes-talitos)
[    2.724312] alg: No test for authenc(hmac(sha224),cbc(aes)) (authenc-hmac-sha224-cbc-aes-talitos-hsna)
[    4.482045] alg: No test for authenc(hmac(md5),cbc(aes)) (authenc-hmac-md5-cbc-aes-talitos)
[    4.490940] alg: No test for authenc(hmac(md5),cbc(aes)) (authenc-hmac-md5-cbc-aes-talitos-hsna)
[    4.500280] alg: No test for authenc(hmac(md5),cbc(des3_ede)) (authenc-hmac-md5-cbc-3des-talitos)
[    4.509727] alg: No test for authenc(hmac(md5),cbc(des3_ede)) (authenc-hmac-md5-cbc-3des-talitos-hsna)
[    6.631781] random: crng init done
[   11.521795] talitos b0030000.crypto: fsl,sec2.2 algorithms registered in /proc/crypto
[   11.529803] driver: 'talitos': driver_bound: bound to device 'b0030000.crypto'

Christophe Leroy (5):
  crypto: talitos - fix ECB and CBC algs ivsize
  crypto: talitos - move struct talitos_edesc into talitos.h
  crypto: talitos - fix hash on SEC1.
  crypto: talitos - eliminate unneeded 'done' functions at build time
  crypto: talitos - drop icv_ool

 drivers/crypto/talitos.c | 104 ++++++++++++++++++++---------------------------
 drivers/crypto/talitos.h |  28 +++++++++++++
 2 files changed, 72 insertions(+), 60 deletions(-)

-- 
2.13.3

