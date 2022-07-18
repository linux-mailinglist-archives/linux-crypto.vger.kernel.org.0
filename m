Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667F2578676
	for <lists+linux-crypto@lfdr.de>; Mon, 18 Jul 2022 17:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbiGRPdy (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 18 Jul 2022 11:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbiGRPdx (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 18 Jul 2022 11:33:53 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46BD2657
        for <linux-crypto@vger.kernel.org>; Mon, 18 Jul 2022 08:33:52 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-31e47ac84daso10960337b3.0
        for <linux-crypto@vger.kernel.org>; Mon, 18 Jul 2022 08:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=xoy34LssYVf1J8u6ZTZ9HCnApyIYFEQxHWoKqeVkQXA=;
        b=VXplJS3/l969KdI701WTwqqLtSpvfnmI7GB2PBsBK9iXVgvplckifDL/VxvLFTljDF
         rwEkKGBCNeWVebJpDa+dLptyqDHK7caLt09Ny2RLjDdykXjIocXK8mPmoALJTEJ6fpVR
         KUSJx/71ZLnF0OPHPckrQ2bjHTwuzIY6Cgzmbq/IaXxh3h+rEHt2kfkaKHiAPmQtxlLX
         e6dCFI/yXB3cQY5DUChBclsNB7BS+8aKGg/xTN8+u/ln5IgQQYFmIwBoa0VZWZ9He/4Z
         yNN5tx0u/uEpp5NTWfCJiCdljh0BVgkj0fWDCPet8Kpv+5q/G73WTACRTlYaTEJRPuKN
         ryZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=xoy34LssYVf1J8u6ZTZ9HCnApyIYFEQxHWoKqeVkQXA=;
        b=z4XNxhSZZ8YYbmLYc0e3Gg24eaBBiQ4HYk1nILLTWRzOAq8MwbUr6gOVGcpXeDlcZx
         KfUs4+tOH4NFmDYgE29nx74REVdxRqdxOFW3Mlp4gcveL/QvJYznv0kRXD89zcWbCPlP
         V1uGuTVhwskoM9BiQaa4a3oWCXv1mMAzgSQX/UFH4my+jyjtZ3slnt1im0PcMLC0lXrE
         QcheOG7X0hcAp1uCiaAWky/GpvZALv86eKWlf6tlOiBs3ACSKXZy5umvDazRenlAWhe3
         /t4bJ/9wB+bPvYIHQiZT2nfSBc/W0sQ/xEdjYav5RFHbFBUpT4Q1/8KMXi3gJGU1ivFc
         DKuw==
X-Gm-Message-State: AJIora/6zvvGACT5PgWoeou9V43CnY4ouOdnHhScFZl4BcKI/hqJfbxf
        0jI+gFLDZ4bufCbNKL7/UJvrh0jYGhzL1bmnQns=
X-Google-Smtp-Source: AGRyM1un/FdFH1VgJ6U4mJX1J69SuOpmCc3B9sFdUls/i7kY0nKeOUZwRrzd4z4F1INt07vhxsWCSnJvml3QlpQOZus=
X-Received: by 2002:a0d:de04:0:b0:31e:d81:29c with SMTP id h4-20020a0dde04000000b0031e0d81029cmr11912347ywe.82.1658158432170;
 Mon, 18 Jul 2022 08:33:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:3a4f:b0:2e8:16b4:a68c with HTTP; Mon, 18 Jul 2022
 08:33:51 -0700 (PDT)
Reply-To: ulricamica13@gmail.com
From:   Ulrica Mica <json12873@gmail.com>
Date:   Mon, 18 Jul 2022 15:33:51 +0000
Message-ID: <CAGZkFEHvGHfpbs_cGu3zC6Rs5Kp_5oCJmGp9+u=qbZ-t8JbqLg@mail.gmail.com>
Subject: re
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1136 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [ulricamica13[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [json12873[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [json12873[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

-- 
Hello Dear Good day to you

Can I talk to you please?

Natalya Merkulova

Best Regards
