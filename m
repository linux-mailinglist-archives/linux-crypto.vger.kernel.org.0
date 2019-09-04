Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4373A7EAB
	for <lists+linux-crypto@lfdr.de>; Wed,  4 Sep 2019 11:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbfIDJBc (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 4 Sep 2019 05:01:32 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35817 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfIDJBc (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 4 Sep 2019 05:01:32 -0400
Received: by mail-ed1-f67.google.com with SMTP id t50so21710201edd.2
        for <linux-crypto@vger.kernel.org>; Wed, 04 Sep 2019 02:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eyPj2vBs2t7A4yBZTnFeRCe0Q/FasNzSKBUIKJqgOio=;
        b=EUChXcRONthLGJ6iT7BP+OMxrrbwyZW62r/qkPFykjb1I08CumezpxVWO8mxcogRCz
         bN8UgYfc7jFvMrYHaUDcEODOPIzgxjQ8+oa/b2+bIOCRZvi9KQUrd9XKbwt4+NNJZsYj
         bYovhg+uMHdFqV+JraTx1Z1PYyBt8pzjyhrrdcujruPZz+n4zqORE/kF/4YVM9/80T1S
         qQmtvUKSubEiGGop8KTz6uyruYbcUePuCiYy2SZyySmXAV34HQf9x6WBWuuBu8lHp5ij
         KEshD3qZeh7gQkiTrZx1aezyydAVEQw6IE1Ir0RuDcxgQ8DOLW/BoUYKmmXVCvUCAmZQ
         aA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eyPj2vBs2t7A4yBZTnFeRCe0Q/FasNzSKBUIKJqgOio=;
        b=AZ6yuY9JyRDzIhZInfrKZ8ovAefx/+jyDv1gP15uKEaIRvMdWah4HUhjuU7LWS98Em
         inAgsyPflW7aq1mczFVQsMUWVQZ1hB7P+8npbbsP7k1IXW7lWmKXWjOQ1LDqntaqniVm
         bTKJW6iLUobBOKuqPkdKIedaMluUdZchbrROHSssuMbFqfL/xoLtP594EheMhItaWn0B
         CY1J1M917ZijzJY998AoKdYgk6S8jnDF+9F0ArjeNPXY+AfjZ2Z2hfXTNp00GVGvle9c
         lXLjHi63ZdTLmTeTbkMqJK6KO1DezaHCJjNB+JsZNYCUBzN9RreDTUZ7KmKF6JtfFc6F
         RTCw==
X-Gm-Message-State: APjAAAXj3FAZsCsAb1pxznWlgpStnrkOP/itvdNLI+7ovyjpNmLCJlFN
        5o+4+glESa+27l6PNau0jRRy6Iy5
X-Google-Smtp-Source: APXvYqxcoJgv6X2HV98U7EbgjJwbCTqkXRYDAx1ku09XCGhiRt+9fU+TRioAgCvZu/tzKxGsUyJfHQ==
X-Received: by 2002:aa7:c456:: with SMTP id n22mr464162edr.96.1567587690162;
        Wed, 04 Sep 2019 02:01:30 -0700 (PDT)
Received: from localhost.localdomain.com ([188.204.2.113])
        by smtp.gmail.com with ESMTPSA id t30sm1473997edt.91.2019.09.04.02.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 02:01:29 -0700 (PDT)
From:   Pascal van Leeuwen <pascalvanl@gmail.com>
X-Google-Original-From: Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
To:     linux-crypto@vger.kernel.org
Cc:     antoine.tenart@bootlin.com, herbert@gondor.apana.org.au,
        davem@davemloft.net,
        Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
Subject: [PATCH 0/3] crypto: inside-secure - Add support for the CBCMAC
Date:   Wed,  4 Sep 2019 09:36:45 +0200
Message-Id: <1567582608-29177-1-git-send-email-pvanleeuwen@verimatrix.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patchset adds support for the (AES) CBCMAC family of authentication
algorithms: AES-CBCMAC, AES-XCBCMAC and AES-MAC
It has been verified with a Xilinx PCIE FPGA board as well as the Marvell
Armada A8K based Macchiatobin development board.

Pascal van Leeuwen (3):
  crypto: inside-secure - Added support for the AES CBCMAC ahash
  crypto: inside-secure - Added support for the AES XCBC ahash
  crypto: inside-secure - Added support for the AES-CMAC ahash

 drivers/crypto/inside-secure/safexcel.c      |   3 +
 drivers/crypto/inside-secure/safexcel.h      |   3 +
 drivers/crypto/inside-secure/safexcel_hash.c | 462 ++++++++++++++++++++++++---
 3 files changed, 427 insertions(+), 41 deletions(-)

-- 
1.8.3.1

