Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C03F2160307
	for <lists+linux-crypto@lfdr.de>; Sun, 16 Feb 2020 10:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgBPJAG (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 16 Feb 2020 04:00:06 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:43888 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726140AbgBPJAF (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 16 Feb 2020 04:00:05 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Tq4XVIS_1581843589;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0Tq4XVIS_1581843589)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 16 Feb 2020 16:59:50 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@kernel.org, pvanleeuwen@rambus.com, zohar@linux.ibm.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Introduce OSCCA certificate and SM2 asymmetric algorithm
Date:   Sun, 16 Feb 2020 16:59:21 +0800
Message-Id: <20200216085928.108838-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hello all,

This new module implement the OSCCA certificate and SM2 public key
algorithm. It was published by State Encryption Management Bureau, China.
List of specifications for OSCCA certificate and SM2 elliptic curve
public key cryptography:

* GM/T 0003.1-2012
* GM/T 0003.2-2012
* GM/T 0003.3-2012
* GM/T 0003.4-2012
* GM/T 0003.5-2012
* GM/T 0015-2012
* GM/T 0009-2012 

IETF: https://tools.ietf.org/html/draft-shen-sm2-ecdsa-02
oscca: http://www.oscca.gov.cn/sca/xxgk/2010-12/17/content_1002386.shtml
scctc: http://www.gmbz.org.cn/main/bzlb.html

These patchs add the OID object identifier defined by OSCCA. The
x509 certificate supports sm2-with-sm3 type certificate parsing
and verification.

The sm2 algorithm is based on libgcrypt's mpi implementation, and has
made some additions to the kernel's original mpi library, and added the
implementation of ec to better support elliptic curve-like algorithms.

sm2 has good support in both openssl and gnupg projects, and sm3 and sm4
of the OSCCA algorithm family have also been implemented in the kernel.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

Thanks,
Tianjia


