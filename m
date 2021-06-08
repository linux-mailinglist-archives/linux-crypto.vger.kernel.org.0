Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8453A05B9
	for <lists+linux-crypto@lfdr.de>; Tue,  8 Jun 2021 23:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbhFHV0H (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 8 Jun 2021 17:26:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54748 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234132AbhFHV0C (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 8 Jun 2021 17:26:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623187448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/gBbRADva2K8JIEOGXkU5f6gFIRmDnT9Lnnhh5Tc3WE=;
        b=JiAbBBySpjmTiT+ko7IMU8+mhpr7IEN271b9gOv7xtdnLlLpES5hdeF079In2moIzNUw3W
        Xx6ffHrCuxElyLhkLAhJZIwWpwVAHHl6GNyJOcohFoa07Yrdaoysj4LULErkIP9/1SGTwN
        sftEA5mT1Y2W/MoihujW1mvEnkRBT64=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-HGUfUKALPCajJa8z2tovBQ-1; Tue, 08 Jun 2021 17:24:07 -0400
X-MC-Unique: HGUfUKALPCajJa8z2tovBQ-1
Received: by mail-oo1-f72.google.com with SMTP id e10-20020a4ab14a0000b029020e1573bdb7so14079474ooo.9
        for <linux-crypto@vger.kernel.org>; Tue, 08 Jun 2021 14:24:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/gBbRADva2K8JIEOGXkU5f6gFIRmDnT9Lnnhh5Tc3WE=;
        b=jJ0v8YkGOipB86yPxcWIGRRVJQXC7Lt6s2lWI1ahrVYQDOjUj8N4+AGfyhxlm1E+dR
         oVLXKl0eM7I7h+XbVey5nz30mOSkyX3ser6w7eNCh79NF5XHjfzKt6C58WCzyg0NhDpk
         aHFL3IfsL6Ju0p552Ze3KhAZQid7aGihOPV4+SPjuQZ1b3ek0nqggrai4gXm79nhB5eX
         Y29xKZHYZafCT5ECf9YLOQ6qRI+bok59S52lFSNY1/3yuttafJqyWCPiC+ddaHdpUdpa
         W0604lvq3tAAzwepsR0sALDpDxOQK9UDCZ/sJE5iSnt5tDsTRU/osc/TmKIkhxHDsIjU
         VWhw==
X-Gm-Message-State: AOAM53263BvtxAeajEHpFSDGBnH18L9QAlMPpxWABZFKbRZIwCExalFh
        IMvR82ptgD98oFoj2mJVAsKjK6p9m+fk3t1mPTwOHF7Tyog/fhjnLyQeM0fmsSXlkif+M8Kv11o
        8YfKrQXc+4FVZX6R+SG7SFgcY
X-Received: by 2002:a05:6808:14e:: with SMTP id h14mr586221oie.151.1623187446579;
        Tue, 08 Jun 2021 14:24:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRUvOvqRt0/CJtj2o0VyI4iVXsRLiR3szXaZyy3Js2xLbhN+wrCnNP4FBaFz2E4YlbUaXjZQ==
X-Received: by 2002:a05:6808:14e:: with SMTP id h14mr586213oie.151.1623187446440;
        Tue, 08 Jun 2021 14:24:06 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x199sm1954310oif.5.2021.06.08.14.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 14:24:06 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org, robh+dt@kernel.org, hao.wu@intel.com,
        corbet@lwn.net, fbarrat@linux.ibm.com, ajd@linux.ibm.com,
        bbrezillon@kernel.org, arno@natisbad.org, schalla@marvell.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        gregkh@linuxfoundation.org, Sven.Auhagen@voleatech.de,
        grandmaster@al2klimov.de
Cc:     linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        linux-staging@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH 02/11] Documentation: fpga: dfl: change FPGA indirect article to an
Date:   Tue,  8 Jun 2021 14:23:41 -0700
Message-Id: <20210608212350.3029742-4-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210608212350.3029742-1-trix@redhat.com>
References: <20210608212350.3029742-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Change use of 'a fpga' to 'an fpga'

Signed-off-by: Tom Rix <trix@redhat.com>
---
 Documentation/fpga/dfl.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
index ccc33f199df2a..ef9eec71f6f3a 100644
--- a/Documentation/fpga/dfl.rst
+++ b/Documentation/fpga/dfl.rst
@@ -57,7 +57,7 @@ FPGA Interface Unit (FIU) represents a standalone functional unit for the
 interface to FPGA, e.g. the FPGA Management Engine (FME) and Port (more
 descriptions on FME and Port in later sections).
 
-Accelerated Function Unit (AFU) represents a FPGA programmable region and
+Accelerated Function Unit (AFU) represents an FPGA programmable region and
 always connects to a FIU (e.g. a Port) as its child as illustrated above.
 
 Private Features represent sub features of the FIU and AFU. They could be
@@ -311,7 +311,7 @@ The driver organization in virtualization case is illustrated below:
              | PCI PF Device |            |          | PCI VF Device |
              +---------------+            |          +---------------+
 
-FPGA PCIe device driver is always loaded first once a FPGA PCIe PF or VF device
+FPGA PCIe device driver is always loaded first once an FPGA PCIe PF or VF device
 is detected. It:
 
 * Finishes enumeration on both FPGA PCIe PF and VF device using common
-- 
2.26.3

