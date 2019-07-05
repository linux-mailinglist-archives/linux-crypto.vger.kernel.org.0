Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3415601CC
	for <lists+linux-crypto@lfdr.de>; Fri,  5 Jul 2019 09:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbfGEHxJ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 5 Jul 2019 03:53:09 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:34542 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbfGEHxJ (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 5 Jul 2019 03:53:09 -0400
Received: by mail-ed1-f42.google.com with SMTP id s49so7447882edb.1
        for <linux-crypto@vger.kernel.org>; Fri, 05 Jul 2019 00:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qDLlCts7NgSR9O7fgyZtvWQtbsqeMjlNA2cWOov+i/U=;
        b=J6NK4tkGAoWmHqi+yMFNGySal/5Ktnup9yv728cDVJzPHLnoHCaChYxXGyTHYngvGN
         hAy0s+DFhN2792c3URWiYojofrO2EN3i+SFQ8wScQAzeIzMvumWt6dGHQNVpsgs2gelz
         9gBR3g4bQgMJmuHNQF9xrb9NRNS7qEmPoeJh436O/RtYPBWzV/jMz2goSMD1c6a+Bb0V
         p4q87BYvL/Kar0iNVcExDpkf/Cd1Gmh9fJC1GuhrIsvoS8wyf/630q3FOyHZ50ZpOizF
         I8wT4y5YLe40zyui0b5Ve8sgzmKGmrk5eyVyz3ef8s05STdrS7SJdXpkN2H3UZjMj2rD
         SfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qDLlCts7NgSR9O7fgyZtvWQtbsqeMjlNA2cWOov+i/U=;
        b=fRzdCNas1SSIhvcRJYs4OzOKXhEAnzzll33uS6iSoDefN28wqSTviQULiKHxGXLD6f
         lO3qkZzUqzchNER52AYt3ajq4XjfiyH1Qp1HpVa7JpuD1xVqZAJpom4vWEpt+8PhFV4+
         qKpLB/lZ7V+bdZth42NiYZdRZnFvjihBknN30qXGcIHz5lMrQEL7wUk9hFjMRN6dRGRq
         yGGlBilNF5t/XGUq/FdY0VV/df42l8CNv0yEpbH9eSTetGvD5xkKDSq4mmmORxfXAgq7
         2VCyLQAuDgRvbgqKcdJ0Pt5WuCGV5AEI4fzjAq5Nx9yJzrCl7lE/QdFsjmZd71T53IJE
         YhFA==
X-Gm-Message-State: APjAAAUf/kTiGoU9/vqDNx7P5lY/5iKp/NxoOxAjdfurUXfgGrga9c4y
        1Kq4yQFK3b7luSLi7mrxyfgW1amt
X-Google-Smtp-Source: APXvYqxB6D7UxBD81XIpwHnsoksdJ+a1KpIXyiSFFitQmDAWQNlH87Xs7ByIQz2KK85x+6BLxtC4eg==
X-Received: by 2002:a50:900d:: with SMTP id b13mr2875617eda.289.1562313187666;
        Fri, 05 Jul 2019 00:53:07 -0700 (PDT)
Received: from localhost.localdomain.com ([188.204.2.113])
        by smtp.gmail.com with ESMTPSA id z2sm1551438ejp.73.2019.07.05.00.53.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2019 00:53:07 -0700 (PDT)
From:   Pascal van Leeuwen <pascalvanl@gmail.com>
X-Google-Original-From: Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
To:     linux-crypto@vger.kernel.org
Cc:     antoine.tenart@bootlin.com, herbert@gondor.apana.org.au,
        davem@davemloft.net,
        Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
Subject: [PATCH 0/3] crypto: inside-secure - add more AEAD ciphersuites
Date:   Fri,  5 Jul 2019 08:49:21 +0200
Message-Id: <1562309364-942-1-git-send-email-pvanleeuwen@verimatrix.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch set adds support for the following additional AEAD suites:
- authenc(hmac(sha1),cbc(des3_ede))
- authenc(hmac(sha1),rfc3686(ctr(aes)))
- authenc(hmac(sha224),rfc3686(ctr(aes)))
- authenc(hmac(sha256),rfc3686(ctr(aes)))
- authenc(hmac(sha384),rfc3686(ctr(aes)))
- authenc(hmac(sha512),rfc3686(ctr(aes)))

It has been verified on an FPGA devboard and Macchiatobin (Armada 8K)

Pascal van Leeuwen (3):
  crypto: inside-secure - add support for
    authenc(hmac(sha1),cbc(des3_ede))
  crypto: inside-secure - added support for rfc3686(ctr(aes))
  crypto: inside-secure - add support for
    authenc(hmac(sha*),rfc3686(ctr(aes))) suites

 drivers/crypto/inside-secure/safexcel.c        |  30 +-
 drivers/crypto/inside-secure/safexcel.h        |  38 +--
 drivers/crypto/inside-secure/safexcel_cipher.c | 456 ++++++++++++++++++++++---
 3 files changed, 428 insertions(+), 96 deletions(-)

-- 
1.8.3.1

