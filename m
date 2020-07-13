Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0707321D1CD
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2020 10:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbgGMIet (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 13 Jul 2020 04:34:49 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:49302 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgGMIet (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 13 Jul 2020 04:34:49 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06D8Ya8P018166;
        Mon, 13 Jul 2020 03:34:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594629276;
        bh=3Bw4YzIcjxMrepbrIHuvj7XqARAi6A7EnKzwBGK3Psk=;
        h=From:To:CC:Subject:Date;
        b=PpMJ/16rTerL0ZoGOUcC4ZghJDIKurf3d1b538RE+7s2Jg4ZgDmNjacH4lwjRzgHc
         OlC6s2hcC6yCSqQzf9gQ5RBuSHJG9qh02D019ZtuxkTMjQdRbP82julPvxfFE+FDtj
         fpRtYNXe2Y8l0I+nIAZ5g2XFST3zIDxpT8GLPbQU=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06D8YaIV040721
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Jul 2020 03:34:36 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 13
 Jul 2020 03:34:36 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 13 Jul 2020 03:34:36 -0500
Received: from sokoban.bb.dnainternet.fi (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06D8YYi2032127;
        Mon, 13 Jul 2020 03:34:35 -0500
From:   Tero Kristo <t-kristo@ti.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>
CC:     <j-keerthy@ti.com>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCHv6 0/7] crypto: add driver for TI K3 SA2UL
Date:   Mon, 13 Jul 2020 11:34:20 +0300
Message-ID: <20200713083427.30117-1-t-kristo@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi,

V6 has only a bunch of static checker warnings fixed. Tested building
with W=1 and C=1 make options, also did a sanity test with crypto
manager tests + extra tests, and did a quick trial with tcrypt.

-Tero


--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
