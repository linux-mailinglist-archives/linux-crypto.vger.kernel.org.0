Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169231EA79B
	for <lists+linux-crypto@lfdr.de>; Mon,  1 Jun 2020 18:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgFAQMt (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 1 Jun 2020 12:12:49 -0400
Received: from smtp02.tmcz.cz ([93.153.104.113]:36144 "EHLO smtp02.tmcz.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbgFAQMt (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 1 Jun 2020 12:12:49 -0400
Received: from smtp02.tmcz.cz (localhost [127.0.0.1])
        by sagator.hkvnode045 (Postfix) with ESMTP id 7670594D866;
        Mon,  1 Jun 2020 18:04:20 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on hkvnode046.tmo.cz
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=8.0 tests=KHOP_HELO_FCRDNS
        autolearn=disabled version=3.3.1
X-Sagator-Scanner: 1.3.1-1 at hkvnode046;
        log(status(custom_action(quarantine(clamd()))),
        status(custom_action(quarantine(SpamAssassinD()))))
X-Sagator-ID: 20200601-180420-0001-83074-R9q4Hu@hkvnode046
Received: from leontynka.twibright.com (109-183-129-149.customers.tmcz.cz [109.183.129.149])
        by smtp02.tmcz.cz (Postfix) with ESMTPS;
        Mon,  1 Jun 2020 18:04:19 +0200 (CEST)
Received: from debian-a64.vm ([192.168.208.2])
        by leontynka.twibright.com with smtp (Exim 4.92)
        (envelope-from <mpatocka@redhat.com>)
        id 1jfmvB-0001Vm-P1; Mon, 01 Jun 2020 18:04:18 +0200
Received: by debian-a64.vm (sSMTP sendmail emulation); Mon, 01 Jun 2020 18:04:17 +0200
Message-Id: <20200601160332.522772720@debian-a64.vm>
User-Agent: quilt/0.65
Date:   Mon, 01 Jun 2020 18:03:32 +0200
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     Mike Snitzer <msnitzer@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Milan Broz <mbroz@redhat.com>, djeffery@redhat.com
Cc:     dm-devel@redhat.com, qat-linux@intel.com,
        linux-crypto@vger.kernel.org, guazhang@redhat.com,
        jpittman@redhat.com
Subject: [PATCH 0/4] Intel QAT fixes
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi

These patches fix bugs in the Intel QAT driver.
https://bugzilla.redhat.com/show_bug.cgi?id=1813394

Mikulas
