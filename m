Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431083A05D2
	for <lists+linux-crypto@lfdr.de>; Tue,  8 Jun 2021 23:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbhFHV0S (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 8 Jun 2021 17:26:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50874 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234406AbhFHV0N (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 8 Jun 2021 17:26:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623187459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9WOcYtG36rVjuPEj8K6lgDL7dCdoY9WpL7jwDyU54B8=;
        b=g1XWXdcZQMPMIfRXd0zkrS3oqjdyVbfRxUMPWoUfgcUM+3quUHJ3aM19opH+WrN1rhPJC4
        zcAnQF5Cjkjap/GuI3XLKhaXHXG99r2HnOpERpioT5ojihTpRbexNn95ioeLPLGgFNhX55
        Ep/MoD9KtfWNy949YGiLPgeYRzNjTNM=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-OyqzghArOCS7BOX4hNI_nA-1; Tue, 08 Jun 2021 17:24:01 -0400
X-MC-Unique: OyqzghArOCS7BOX4hNI_nA-1
Received: by mail-oi1-f200.google.com with SMTP id l1-20020a5441010000b02901ecd2ee1861so8947878oic.13
        for <linux-crypto@vger.kernel.org>; Tue, 08 Jun 2021 14:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9WOcYtG36rVjuPEj8K6lgDL7dCdoY9WpL7jwDyU54B8=;
        b=iIvw0Kra5tPmqUAwKosxvqt78qSnnRSs7wWHZmK8XulC/nyW2isjHzEbiazTM1as3D
         2UhUCT7d6CGDGXdZINruyFbSWLSn9V5eTdn0T+kvUFYjIkvRXxQn/E5/Uhpb5tCFSb7D
         ehKiaqpbA41Biv2jbI3XayaChAFyArCNKy2bsnkrAcdgxgxF3bOyAMo8Qui3suk/KZ3f
         rdM9C1jGUIVZ9oxl++iT99utaaYZNsKgzmcWW5SMVUEI/omB5tOOOMtv31A84SXYeA/L
         F+MQ7Ru5y+vXJhPA9COXvlyWGVrXUjMOCkOHd43tbJwQnWiNKhTcZwkXAxNEoK5ypI6W
         ZuMA==
X-Gm-Message-State: AOAM530aIBqQ/ujCVGmOKGRn9zbhkJVfHwuaG4c4Y50EM1MC0KYS9OVQ
        wXWYwMQVukojzWpk7pa2F70sCptAMW5pSGzBulOZ+7uF+hV2/mc1X1N2SwDHsGRrw5ZyEryGfqI
        LRPWBz/r7+sRag8JeGLGrhyII
X-Received: by 2002:a54:4091:: with SMTP id i17mr4211778oii.96.1623187439561;
        Tue, 08 Jun 2021 14:23:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/slvYeAdnbZ/SPI7BCq6DWlaOdgzks9roBFKWnERshaA7TkLI+lr32K9zzB6m1V9KMz0o0A==
X-Received: by 2002:a54:4091:: with SMTP id i17mr4211765oii.96.1623187439400;
        Tue, 08 Jun 2021 14:23:59 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x199sm1954310oif.5.2021.06.08.14.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 14:23:59 -0700 (PDT)
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
Subject: [PATCH 00/11] fpga: change FPGA indirect article to an
Date:   Tue,  8 Jun 2021 14:23:38 -0700
Message-Id: <20210608212350.3029742-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A treewide followup of
https://lore.kernel.org/linux-fpga/2faf6ccb-005b-063a-a2a3-e177082c4b3c@silicom.dk/

Change the use of 'a fpga' to 'an fpga'
Ref usage in wiki
https://en.wikipedia.org/wiki/Field-programmable_gate_array
and Intel's 'FPGAs For Dummies'
https://plan.seek.intel.com/PSG_WW_NC_LPCD_FR_2018_FPGAforDummiesbook

Change was mechanical
 !/bin/sh                                                        
 for f in `find . -type f`; do
   sed -i.bak 's/ a fpga/ an fpga/g' $f
   sed -i.bak 's/ A fpga/ An fpga/g' $f
   sed -i.bak 's/ a FPGA/ an FPGA/g' $f
   sed -i.bak 's/ A FPGA/ An FPGA/g' $f
 done


Tom Rix (11):
  dt-bindings: fpga: fpga-region: change FPGA indirect article to an
  Documentation: fpga: dfl: change FPGA indirect article to an
  Documentation: ocxl.rst: change FPGA indirect article to an
  crypto: marvell: cesa: change FPGA indirect article to an
  fpga: change FPGA indirect article to an
  fpga: bridge: change FPGA indirect article to an
  fpga-mgr: change FPGA indirect article to an
  fpga: region: change FPGA indirect article to an
  fpga: of-fpga-region: change FPGA indirect article to an
  fpga: stratix10-soc: change FPGA indirect article to an
  staging: fpgaboot: change FPGA indirect article to an

 .../devicetree/bindings/fpga/fpga-region.txt  | 22 +++++++++----------
 Documentation/fpga/dfl.rst                    |  4 ++--
 .../userspace-api/accelerators/ocxl.rst       |  2 +-
 drivers/crypto/marvell/cesa/cesa.h            |  2 +-
 drivers/fpga/Kconfig                          |  4 ++--
 drivers/fpga/fpga-bridge.c                    | 22 +++++++++----------
 drivers/fpga/fpga-mgr.c                       | 22 +++++++++----------
 drivers/fpga/fpga-region.c                    | 14 ++++++------
 drivers/fpga/of-fpga-region.c                 |  8 +++----
 drivers/fpga/stratix10-soc.c                  |  2 +-
 drivers/staging/gs_fpgaboot/README            |  2 +-
 include/linux/fpga/fpga-bridge.h              |  2 +-
 include/linux/fpga/fpga-mgr.h                 |  2 +-
 13 files changed, 54 insertions(+), 54 deletions(-)

-- 
2.26.3

