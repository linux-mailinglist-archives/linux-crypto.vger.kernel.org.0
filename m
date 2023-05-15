Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE60770238F
	for <lists+linux-crypto@lfdr.de>; Mon, 15 May 2023 07:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbjEOFvC (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 15 May 2023 01:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235622AbjEOFuS (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 15 May 2023 01:50:18 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCAE2D64
        for <linux-crypto@vger.kernel.org>; Sun, 14 May 2023 22:50:04 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1ab0c697c2bso113639515ad.1
        for <linux-crypto@vger.kernel.org>; Sun, 14 May 2023 22:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1684129804; x=1686721804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wcGbfhUP5NrwGCYl7Q1yL0FMzRdJBr1PIlnUSkktJs=;
        b=n/aiVJ2ZI/20dmw/nnIas4SmVxjrQZ4QoNuC10rt/EBsMYeY3s9rOAtcRswQ/rS0gj
         +YF3uZ3+BrCTAsb8/zas05gp3eHMHogoCDyF5CgphQCtWV7jDS0w6dAIyI/LOHIuFUD/
         66tP/o1kfQ8lwgIgmMGChYLD4QdvhYXxlgITerrPqiWqRvbQqD1j+FMl1+Z+T/R1rPbg
         biqO2FNrYffCTix/m9i9JkHtz7X1ewyYTYJ/wpngbMBRGNjNr/kfcPGXoWWvX02AFi5Z
         JZRL5gwnt9JqBz9jMuE4h8qnmO/g76/vz4OrXrBsX3Ex3DVowPdQK8yPfYn/rHP5EbLV
         lenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684129804; x=1686721804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wcGbfhUP5NrwGCYl7Q1yL0FMzRdJBr1PIlnUSkktJs=;
        b=D9rZtkdhD2sczoZnhcQr8qCMRJwrbuVqnBWUWKfhvGw1b6AwAxf3ffapMsSIoFExkm
         Jwxwbm0Z+xx6/LKaLX4j5pEPBsCtPF18u1lgWxdN+uPwABm5HHJ8tF7fn9KFHaVB9JN6
         CAKkzOwFL/hIdAFjCJ4oSK21qFuQpj1Fe7MUNzbJPo8GrbuslMxW+tdglTM66IlA7+fy
         8irelBtYLpASjXAMIPo3M5iHHAtGBtuLiZT2ojDu16mQMhM9QBPb4d2yMt33RBbjB4Qd
         tgMEkVt+Z5CCVE9SFImQGtS5eXkx3fmM8njWWsvKvQ2P6FMR/1D11fk3idN/mniEjFC5
         3drA==
X-Gm-Message-State: AC+VfDzCzoXAPJkYjwape0XprvDWXwuhfBjKAIRTh7JixocgB9X33s1h
        y4MTk/jGxdhHyMrTgZByO2CefQ==
X-Google-Smtp-Source: ACHHUZ5G5pSurpLSfBqE/5dREIdQpF2iiBuall6PO0uWHa8iwPoH3QvLtzsBkdmMfKChnq/qafBiBQ==
X-Received: by 2002:a17:902:c1cd:b0:1ab:18ea:f922 with SMTP id c13-20020a170902c1cd00b001ab18eaf922mr32696313plc.52.1684129804048;
        Sun, 14 May 2023 22:50:04 -0700 (PDT)
Received: from localhost.localdomain ([106.51.191.118])
        by smtp.gmail.com with ESMTPSA id f10-20020a17090274ca00b001ab28f620d0sm12423277plt.290.2023.05.14.22.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 22:50:03 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Marc Zyngier <maz@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH V6 04/21] ACPI: tables: Print RINTC information when MADT is parsed
Date:   Mon, 15 May 2023 11:19:11 +0530
Message-Id: <20230515054928.2079268-5-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230515054928.2079268-1-sunilvl@ventanamicro.com>
References: <20230515054928.2079268-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

When MADT is parsed, print RINTC information as below:

ACPI: RISC-V INTC (acpi_uid[0x0000] hart_id[0x0] enabled)
ACPI: RISC-V INTC (acpi_uid[0x0001] hart_id[0x1] enabled)
...
ACPI: RISC-V INTC (acpi_uid[0x000f] hart_id[0xf] enabled)

This debug information will be very helpful during bring up.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/acpi/tables.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 7b4680da57d7..8ab0a82b4da4 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -220,6 +220,16 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 		}
 		break;
 
+	case ACPI_MADT_TYPE_RINTC:
+		{
+			struct acpi_madt_rintc *p = (struct acpi_madt_rintc *)header;
+
+			pr_debug("RISC-V INTC (acpi_uid[0x%04x] hart_id[0x%llx] %s)\n",
+				 p->uid, p->hart_id,
+				 (p->flags & ACPI_MADT_ENABLED) ? "enabled" : "disabled");
+		}
+		break;
+
 	default:
 		pr_warn("Found unsupported MADT entry (type = 0x%x)\n",
 			header->type);
-- 
2.34.1

