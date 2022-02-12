Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10B64B37A2
	for <lists+linux-crypto@lfdr.de>; Sat, 12 Feb 2022 20:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiBLTkk (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 12 Feb 2022 14:40:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiBLTkj (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 12 Feb 2022 14:40:39 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AA6606CC
        for <linux-crypto@vger.kernel.org>; Sat, 12 Feb 2022 11:40:35 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d187so22129949pfa.10
        for <linux-crypto@vger.kernel.org>; Sat, 12 Feb 2022 11:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=8+4bnTKYSEomgov0fN4WSzB8Yls69bRxwVLBV1+X8+k=;
        b=B/ajT4Lh6m6DVAkKDwI9inMaK35fvAQ3ytrEkdBpJCeLlieHXSZjCwoBPO2oHGGytf
         v4c4CEwWtnPDzr6PS1Mpm89KIwENf8shyr59byx0pie2DMAMBbyvJqrkPAEaMmClEKy6
         6WpanjWuygbaw/9Y9hL5SdfzBL0Od+gKOMR9wcRjdpq2TadfFbpZYafrpJl5cTrhot8K
         wkDcMXcu2t0LP2b+dibRUbfLEkKCK+GMj41BfbztA1YXx+RVGT/dNWDg8Nx7906xaPf4
         eqqr6DCQK3ZXHfduICdUyK187UQ9XezoXpDKuY1ZwPQpMDqKxc7NZkXrBNIcFY/Lk77A
         5ZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8+4bnTKYSEomgov0fN4WSzB8Yls69bRxwVLBV1+X8+k=;
        b=n7TbWst47UwjpC00EHZdpBOQSWyi7MegBWATYSb7iZ3SHbIksz06JLxi4VH7E3Y6iX
         7Q5U24NwfJmnNBOByWG+5bExZCQcjt09rhuxOkEPE4Ht3/5VDS23fkh2TL0u+cU8sxMX
         Tp0O9ztWb0itCBwcEqAcyp3eaVucIN+gbZUeXpjeYYoScxraV/UTUiMwphOuqoav2wNY
         YRb1tgCZzhmmnCJPEXm2Y1fOgT/8R0xr3yT3YjB3aYjAVygfUcjBJIaU7Fh3Luzr8w9p
         9M52kXwpg2LzQGVgLgR/gXeJXpGXakSQv5rF4kJ0zVnrwwizYk7+DP/8ThcElLAa9erF
         sDdQ==
X-Gm-Message-State: AOAM533ASdlj+KiDGfE941HqlQQ2D8Ouy42xiVto8ftBpSOjPWwuM54H
        gFmMuj4bh81zoUoNOW/MKLA7BVFvsLsQ/3dGSjo=
X-Google-Smtp-Source: ABdhPJxQ7gLH+N6bTq/F+vKddeqSjdiEs2gLqol+NOkYQh0DZKuRctFYr3lLtIiGMhQXlg2WZ/g737SCQJhMqAu+ML4=
X-Received: by 2002:a05:6a00:228e:: with SMTP id f14mr7503399pfe.33.1644694835166;
 Sat, 12 Feb 2022 11:40:35 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:90a:880f:0:0:0:0 with HTTP; Sat, 12 Feb 2022 11:40:34
 -0800 (PST)
From:   Ulrica Mica <ulricamica877@gmail.com>
Date:   Sat, 12 Feb 2022 11:40:34 -0800
Message-ID: <CAEpn3rHF3MZz=+QM3bLpxs9u8ckhSmMWy-r8dq=08Xvpuf2-4A@mail.gmail.com>
Subject: good morning
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

-- 
Hello dear
Can i talk to you please?
Ulrica
