Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46C89B2406
	for <lists+linux-crypto@lfdr.de>; Fri, 13 Sep 2019 18:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388631AbfIMQXd (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 13 Sep 2019 12:23:33 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:42911 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388221AbfIMQXd (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 13 Sep 2019 12:23:33 -0400
Received: by mail-ed1-f51.google.com with SMTP id y91so27550222ede.9
        for <linux-crypto@vger.kernel.org>; Fri, 13 Sep 2019 09:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zpmldQ5WUFePVov/0ZwQq+NH0OL8Uftbfd6K9qHxRnY=;
        b=V7PKLnNELww8rIjXzxtrPV8DCwt4H3+UVgUmwpNaHP3fjBS7tsfsYIcn1nkTxEEQEd
         2rQGzNYU7AIbVSPkAcv9wjMG92JlVEK2r0wlHSQ94cZ5jL+ZwyOmEPYxQrhOPntmV002
         l+opa3Dgb4VJNrZA0YEgyHWjK2lV0BwccUGwZDjiRM5ZkQBfu1iJNJjUCwcIub8pjOGX
         bIufrlAyQkJWI1p5MX/IHx8v65cvf7BkEYNDvy3ScTNPmk7uUrn2mC5MZSTRlevk2tEm
         S4cbEVNsTMMsZHWZbrWRD6aNMyAFOOK42EbqQ37o39Bn3MXPAGl+9G2ZBJgYFBqMV60o
         iUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zpmldQ5WUFePVov/0ZwQq+NH0OL8Uftbfd6K9qHxRnY=;
        b=Ml33ERfhHXrDJ/RVPP7Z5zkBRJfDqbT1mVDP/LzV7jfwt4YR3xVEWg8QcsDLd5xdn3
         XJ5zypN/7CjqZuYbfNGwvdVDJibmLM4HDnMAAIwv0WHX0FB+2BtBEJ7Wdow1KhAB6O+o
         /iviYjv6uAqtq74AKXtHJz03ARX9IO+bsTkUFLLTli0kWS9AOpP/vaIn4mzWmqE6+083
         wvvLxOvAuY+2A7mf8z/OE7yW35/B3Lf+fu00cpE2XEhIZaWqCvLx2WhsvDEsxGR+t/rb
         VFVU6MIL4N7lV3ft20heLlU9UrrdpveqOYVNUus6lJ2DnKvZgqIj3S4gwJPfCI/GyZXd
         gjJQ==
X-Gm-Message-State: APjAAAXa57NU1GSoVQSleAQh9vRRLvMRCOu91ww2tfoWcmiBER7t/E1F
        fK9jsfR9j5Ea6SbBdrLqczT3HM3M
X-Google-Smtp-Source: APXvYqyqyBntYpljtDNZrNNxhkLHuA/UJmiVcSQavvh9LFCVXxeHwMTWbrJUA9oVwycKj1TsM6QbvA==
X-Received: by 2002:a50:b501:: with SMTP id y1mr48288588edd.167.1568391811562;
        Fri, 13 Sep 2019 09:23:31 -0700 (PDT)
Received: from localhost.localdomain.com ([188.204.2.113])
        by smtp.gmail.com with ESMTPSA id r18sm5497669edl.6.2019.09.13.09.23.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Sep 2019 09:23:30 -0700 (PDT)
From:   Pascal van Leeuwen <pascalvanl@gmail.com>
X-Google-Original-From: Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
To:     linux-crypto@vger.kernel.org
Cc:     antoine.tenart@bootlin.com, herbert@gondor.apana.org.au,
        davem@davemloft.net,
        Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
Subject: [PATCHv3 0/3] crypto: inside-secure - Add support for (HMAC) SM3
Date:   Fri, 13 Sep 2019 17:20:35 +0200
Message-Id: <1568388038-1268-1-git-send-email-pvanleeuwen@verimatrix.com>
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

changes since v2:
- allow compilation if CONFIG_CRYPTO_SM3 is not set

Pascal van Leeuwen (3):
  crypto: inside-secure - Added support for basic SM3 ahash
  crypto: inside-secure - Added support for HMAC-SM3 ahash
  crypto: testmgr - Added testvectors for the hmac(sm3) ahash

 crypto/testmgr.c                             |   6 ++
 crypto/testmgr.h                             |  56 +++++++++++
 drivers/crypto/inside-secure/safexcel.c      |   2 +
 drivers/crypto/inside-secure/safexcel.h      |   9 ++
 drivers/crypto/inside-secure/safexcel_hash.c | 134 +++++++++++++++++++++++++++
 5 files changed, 207 insertions(+)

-- 
1.8.3.1

