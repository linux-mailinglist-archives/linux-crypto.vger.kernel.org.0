Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 927ED7C8A3
	for <lists+linux-crypto@lfdr.de>; Wed, 31 Jul 2019 18:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfGaQ2G (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 31 Jul 2019 12:28:06 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:35673 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfGaQ2F (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 31 Jul 2019 12:28:05 -0400
Received: by mail-ed1-f43.google.com with SMTP id w20so66224461edd.2
        for <linux-crypto@vger.kernel.org>; Wed, 31 Jul 2019 09:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=R9blEA6ZnOMJWvTyIeSRLrLEZW39U0PIeriu862dkv8=;
        b=JT3xBSr56BOZq8vinyC/6fpxmKYab1d4gNBo86UF6XTlAULQEAY9sx+fA8Lciv35Sf
         i54c6u3pIgVb9pKeM/TqB9ClA+CAEfCffes0U3Wv3QI8VF6lJ5htj5At/q2YM9oLC3hx
         qHviEcLEg5YMe0/WraqezVhAfaAn9ruIHjycOmBOgP09U4V+p7pgT41f0Nb7W+Ne0HHT
         zwFQVTDHcn6IPBltsUAb6//1lyOkAKkcdIBE96xi9F1Z1aElzdyBsk/EileVDAILZGAP
         qjWBAdPmOZxeSzsW1Uru7OwGmDSpJ8flRIqfY/6lJJM0COXmN8UsWQ04oj15nWST+hyx
         BL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=R9blEA6ZnOMJWvTyIeSRLrLEZW39U0PIeriu862dkv8=;
        b=mDA5Zbr+ugF4Uqbgvs66XGHEcNWTPmC+E91nsPgL5BjW9ZHrMG/w2DGP6aq9bmF9JG
         eP5qKT2OpFfMhZc11FE2+EWIlOoafnZ7Wsg+AoFhSvF480qrjG1gdsydNmT0NmK6/DAV
         AwLcK+oupAuwKbeKFq2HiAsc4QsxlbHPgvokWzTQ79xRybku15ZN8N3QMtf/Lke79A7A
         RJTZ4jQJy4jby3BVocPQFnQ3fD+yHCMn0Yig1rVB4GRYYuQ2pxz7bfPQzrTsg3oCGdAa
         MaDPrj/wU8VRo4TEUh+Cv/kgTayojgVUUfD/5MbjiRC7jCd+C2DJfohdqIgn+r2Oj9W4
         h57A==
X-Gm-Message-State: APjAAAVOnyRcElkyVnhGDYSWL/yubo64UOVrUYCxHolvfmpDVCj6ySu8
        ZScMaqv8Gr86HGZBzEOhqxqJYZ8T
X-Google-Smtp-Source: APXvYqyh36KwuYlmAGU2hGwj4Etn4qiPgUAdCnRsZFPqqWZzVnRKsPs6jvQDtG4Lj9E+t2udKDAO4A==
X-Received: by 2002:a05:6402:145a:: with SMTP id d26mr107675487edx.10.1564590483557;
        Wed, 31 Jul 2019 09:28:03 -0700 (PDT)
Received: from localhost.localdomain.com ([188.204.2.113])
        by smtp.gmail.com with ESMTPSA id w35sm17418264edd.32.2019.07.31.09.28.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 09:28:02 -0700 (PDT)
From:   Pascal van Leeuwen <pascalvanl@gmail.com>
X-Google-Original-From: Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
To:     linux-crypto@vger.kernel.org
Cc:     antoine.tenart@bootlin.com, herbert@gondor.apana.org.au,
        davem@davemloft.net,
        Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
Subject: [PATCHv3 0/4] crypto: inside-secure - broaden driver scope
Date:   Wed, 31 Jul 2019 17:25:26 +0200
Message-Id: <1564586730-9629-1-git-send-email-pvanleeuwen@verimatrix.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This is a first baby step towards making the inside-secure crypto driver
more broadly useful. The current driver only works for Marvell Armada HW
and requires proprietary firmware, only available under NDA from Marvell,
to be installed. This patch set allows the driver to be used with other
hardware and removes the dependence on that proprietary firmware.

changes since v1:
- changed dev_info's into dev_dbg to reduce normal verbosity
- terminate all message strings with \n
- use priv->version field strictly to enumerate device context
- fixed some code & comment style issues
- removed EIP97/197 references from messages
- use #if(IS_ENABLED(CONFIG_PCI)) to remove all PCI related code
- use #if(IS_ENABLED(CONFIG_OF)) to remove all device tree related code
- do not inline the minifw but read it from /lib/firmware instead

changes since v2:
- split off removal of alg to engine mapping code into separate patch
- replaced some constants with nice defines
- added missing \n to some error messages
- removed some redundant parenthesis
- aligned some #if's properly
- added some comments to clarify code
- report error on FW load for unknown HW instead of loading EIP197B FW
- use readl_relaxed() instead of readl() + cpu_relax() in polling loop
- merged patch "fix null ptr dereference on rmmod for macchiatobin" here
- merged patch "removed unused struct entry"

Pascal van Leeuwen (4):
  crypto: inside-secure - make driver selectable for non-Marvell
    hardware
  crypto: inside-secure - Remove redundant algo to engine mapping code
  crypto: inside-secure - add support for PCI based FPGA development
    board
  crypto: inside-secure - add support for using the EIP197 without
    vendor firmware

 drivers/crypto/Kconfig                         |  12 +-
 drivers/crypto/inside-secure/safexcel.c        | 761 +++++++++++++++++--------
 drivers/crypto/inside-secure/safexcel.h        |  43 +-
 drivers/crypto/inside-secure/safexcel_cipher.c |  11 -
 drivers/crypto/inside-secure/safexcel_hash.c   |  12 -
 drivers/crypto/inside-secure/safexcel_ring.c   |   3 +-
 6 files changed, 586 insertions(+), 256 deletions(-)

--
1.8.3.1
