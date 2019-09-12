Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED36BB0C5A
	for <lists+linux-crypto@lfdr.de>; Thu, 12 Sep 2019 12:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731002AbfILKND (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 12 Sep 2019 06:13:03 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:34535 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730386AbfILKND (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 12 Sep 2019 06:13:03 -0400
Received: by mail-ed1-f54.google.com with SMTP id c20so14422739eds.1
        for <linux-crypto@vger.kernel.org>; Thu, 12 Sep 2019 03:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=a2HG96k5o73Pb8e0OGzTZYLUCyXrY3SX4Xnq0PpMKX0=;
        b=EttcEU+Fylj/r1H+Lc0TdJN8yThNckPEAPkmJ6cayl2KbXPK/ghlaqA0o4Gh5L4/Ov
         KbFTuN9v1wmgm32Fx6DNzcJ1GKOqhrWtL1uKRHe/ZRh8THL+tOMYOrwNmgtoQrxbXdfP
         PFWS+qeLh0Sayzdv0DdEuI2lvcv9mXvfoMfCtoVDQe8yvF0MolNvoBUUgFkevrseRciu
         wxTWMLfOnkR0egiAmCphy0Rgz4b/Riwzd1aDNAmSjUlgA64uv5YSjGai4gElLHlPcbyX
         nL0Ss4V0mEHZcSzrIsmbnwRgSCSnJOJLYsLNo3KPDjDBP+1seYs/PWesWJFWQAvF07aX
         98Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=a2HG96k5o73Pb8e0OGzTZYLUCyXrY3SX4Xnq0PpMKX0=;
        b=hH9DAbmAJZR3Z6pGx7NpXZ+orEayXJB1ejOx2S7ly69t0ob8+RPrJiQwZTZGRtOmR3
         nJvmCNbRElwC32HojGynAx1W9P+MvIGYQbp4PR7LVnymARynDJsUJQhYywkgiB2I09Zr
         MjzmHlzKonGBbFQKzDKFbgt9GKqSQPVTzPPa0W3ITxais4b42Sg3orc6tdAdEkVVqJdO
         P1Ij0ODHLs2qyiQF/dYFCvXXdAsgEJHrB0mev3BDo8mW4QRMj5mFzRGFxxoSdzVnB0lQ
         96tVMXQiOASAJNXxZvkCjTFGr+b41/wHSZxJy+T4VDSqgcG7OVlpiEcny1OyaWCzFNSg
         DfNg==
X-Gm-Message-State: APjAAAXQmKlJGMPvE/jL7I5g/ZyTOy1Is5eC5sWnKi8oc03vohGOOoHZ
        yoXrIoshv13GLztzRBwDhGlMO7ap
X-Google-Smtp-Source: APXvYqwJzioiXRO5gpmTPQ5gg8Hj19D+cFFKZ3P/pZwIF7SFsRk8+TmoVLqHRkNaYWow5tUsHsWI1g==
X-Received: by 2002:a17:906:eb92:: with SMTP id mh18mr34080355ejb.298.1568283181487;
        Thu, 12 Sep 2019 03:13:01 -0700 (PDT)
Received: from localhost.localdomain.com ([188.204.2.113])
        by smtp.gmail.com with ESMTPSA id k11sm2561499ejr.3.2019.09.12.03.13.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 03:13:00 -0700 (PDT)
From:   Pascal van Leeuwen <pascalvanl@gmail.com>
X-Google-Original-From: Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
To:     linux-crypto@vger.kernel.org
Cc:     antoine.tenart@bootlin.com, herbert@gondor.apana.org.au,
        davem@davemloft.net,
        Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
Subject: [PATCHv2 0/3] crypto: inside-secure - Add support for (HMAC) SM3
Date:   Thu, 12 Sep 2019 11:10:11 +0200
Message-Id: <1568279414-16773-1-git-send-email-pvanleeuwen@verimatrix.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Extend driver support with sm3 and hmac(sm3) ahash support.
Also add GM/T 0042-2015 hmac(sm3) testvectors to the testmgr.
The patchset has been tested with the eip197c_iewxkbc configuration
on the Xilinx VCU118 development board, including the crypto extra tests.

Note that this patchset applies on top of the earlier submitted
"Add support for the Chacha20 kcipher and the Chacha20-Poly..." series.

changes since v1:
- incorporated feedback by Antoine Tenart, see individual patches for
  details

Pascal van Leeuwen (3):
  crypto: inside-secure - Added support for basic SM3 ahash
  crypto: inside-secure - Added support for HMAC-SM3 ahash
  crypto: testmgr - Added testvectors for the hmac(sm3) ahash

 crypto/testmgr.c                             |   6 ++
 crypto/testmgr.h                             |  56 ++++++++++++
 drivers/crypto/inside-secure/safexcel.c      |   2 +
 drivers/crypto/inside-secure/safexcel.h      |   3 +
 drivers/crypto/inside-secure/safexcel_hash.c | 129 +++++++++++++++++++++++++++
 5 files changed, 196 insertions(+)

-- 
1.8.3.1

