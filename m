Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD08B2657
	for <lists+linux-crypto@lfdr.de>; Fri, 13 Sep 2019 21:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbfIMT7k (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 13 Sep 2019 15:59:40 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:37192 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfIMT7j (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 13 Sep 2019 15:59:39 -0400
Received: by mail-ed1-f43.google.com with SMTP id i1so28092058edv.4
        for <linux-crypto@vger.kernel.org>; Fri, 13 Sep 2019 12:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zODf0erXlP5r5hqs+Y+lt7+Kcr2ro0/Ks6IEo/vgro0=;
        b=FXS7ocGtfxWcN9iMwl2VDxbmk22rHJB+YnXIIt+cFya9Sz96b0jWEttY45Y2wNCxp+
         mXmP1SiYoaBCDuGLpaHUucOUtNNXE1zUdcQ8i97AAuBj7KXkq6DTN67XYLpvrF30gjc0
         J2vI48SCMVpSleU2gxSMH46MmBt2XW+cpHbnfsrqfO9Amp6kLtqWU2ZOzvLbCdLAEqPU
         Gx0VCkj8UurUWVJmxFJWg1o1g8DeXZasEHPNETwsYTFHL4OPCigIJ0xzbMcogDxcA7fQ
         SFWqd0lC3ujGLiwkJ24lDU92a0ggJzmBV1AYI4+MeKj7+60Qzrf+fRtCreWhSynSyBIc
         PF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zODf0erXlP5r5hqs+Y+lt7+Kcr2ro0/Ks6IEo/vgro0=;
        b=SBqi0TZtB4auecZG1OdY437K7S3RPlLPMFZRdtCfJ7HNATzJOAEKNiWS/nni3Anut8
         M2FU+7gUcsOq7scvBjWDms5k99CyPqg/EnBFj0ne9l8hfADFPFN3C6reIjd+A78G5Rvq
         G9h/J21YqfK/erHI8EQ6gY2u9UyC6hjqiKzC/cKupls3xTKU1vAJW7uT1sdxyCnShUXB
         6zw+gyr72nAWKVB85bUxR0bpYI1eGraSvlVeDryAFlPfxnYRjOvW72NcEZQfK47iVV2t
         Ut/kiUjZ4lxwfRo6nU9gZxk3HJLuNyv3mew152R8O0l+Hv7yCboir0HRuKzDaX+RJ2J3
         gvJQ==
X-Gm-Message-State: APjAAAXTZkUtvHqCWbHLgksCr8bUJ3ronMTnoJVCX2aO5O7PVdgzmbsS
        g/pZXMeHj1XyQRXa1xRomZW20yFU
X-Google-Smtp-Source: APXvYqzB/eT3XTEu7OmwUPM/pyukM2+hEWNLvl+uFjjIPXNibcXgccRXBVS2j0xElGS6XInf6CVw8g==
X-Received: by 2002:a17:906:a851:: with SMTP id dx17mr41328502ejb.116.1568404777378;
        Fri, 13 Sep 2019 12:59:37 -0700 (PDT)
Received: from localhost.localdomain.com ([188.204.2.113])
        by smtp.gmail.com with ESMTPSA id a50sm4592579eda.25.2019.09.13.12.59.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Sep 2019 12:59:36 -0700 (PDT)
From:   Pascal van Leeuwen <pascalvanl@gmail.com>
X-Google-Original-From: Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
To:     linux-crypto@vger.kernel.org
Cc:     antoine.tenart@bootlin.com, herbert@gondor.apana.org.au,
        davem@davemloft.net,
        Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
Subject: [PATCHv2 0/3] crypto: inside-secure - Add (HMAC) SHA3 support
Date:   Fri, 13 Sep 2019 20:56:46 +0200
Message-Id: <1568401009-29762-1-git-send-email-pvanleeuwen@verimatrix.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patchset adds support for all flavours of sha3-xxx and hmac(sha3-xxx)
ahash algorithms.

The patchset has been tested with the eip197c_iewxkbc configuration on the
Xilinx VCU118 development board, including the testmgr extra tests.

changes snce v1:
- fixed crypto/Kconfig so that generic fallback is compiled as well 

Pascal van Leeuwen (3):
  crypto: inside-secure - Add SHA3 family of basic hash algorithms
  crypto: inside-secure - Add HMAC-SHA3 family of authentication
    algorithms
  crypto: Kconfig - Add CRYPTO_SHA3 to CRYPTO_DEV_SAFEXCEL

 drivers/crypto/Kconfig                       |   1 +
 drivers/crypto/inside-secure/safexcel.c      |   8 +
 drivers/crypto/inside-secure/safexcel.h      |  13 +
 drivers/crypto/inside-secure/safexcel_hash.c | 790 ++++++++++++++++++++++++++-
 4 files changed, 800 insertions(+), 12 deletions(-)

-- 
1.8.3.1

