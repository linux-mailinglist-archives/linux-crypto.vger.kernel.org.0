Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD084D3F4A
	for <lists+linux-crypto@lfdr.de>; Thu, 10 Mar 2022 03:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236755AbiCJCjK (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 9 Mar 2022 21:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236495AbiCJCjJ (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 9 Mar 2022 21:39:09 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230335A097
        for <linux-crypto@vger.kernel.org>; Wed,  9 Mar 2022 18:38:10 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id g17so7090012lfh.2
        for <linux-crypto@vger.kernel.org>; Wed, 09 Mar 2022 18:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=4SL1/qbkTptdsuZGoXAM80S4DBJva1Vt53CdfbCl4nw=;
        b=g9tJEnDj1t90F+Aittko5r0FLVZJTT7qFG8SG6OVyh7agYxizoio8S2WyezAKyyKjN
         0CGHssBniWBTbZDfLlQNY8WHUanTIZgdWLhM8BR2LjL1fxSHIl1mz44ZYJNNBGnC5s9f
         Z0NCX+/90WNiQpIIyLtbpWlBgK1MhrqswVtZhPLFbdTGQMcIG2QibzASCwncDDkdOT1P
         vyRePy+8I1UFHFlye98oSWLiPSnHXgJ5S7CcNgyKuJbiU+t7XruZJpLiU12rJKRm3HJv
         X6046dzIg2qcIKahAo8L0ILwxO2NxyBBQf0H7bMBjKAhphWQBuCjnr+NZBkQ3t0nskCJ
         KPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=4SL1/qbkTptdsuZGoXAM80S4DBJva1Vt53CdfbCl4nw=;
        b=e8GRpGX33oUIeEVYhx6+/iIbfU9wP82xOk+/3/PGSHs1DjgI9EOCt7Wu13QHNYED70
         bonqimitfDqIp8+ldPBLT0iXECdm74/EDbSp6xHr285tdSTgWoJpPx48msB5F/87pDOw
         Vw3jyES9ivVtpIB+nd8+5P+zwBwVlXdPBcSEMf99aKcuBJ/Ar+OrTCxrtILJC3DXM9+C
         WGcqyygJAvmvBdLhxFaCv0W732A2hitH7/oGt/68s6e9LT52dOoXf30joUgOh6QkF+3v
         haZVGhUrlo1uF7NyZq5zboOviR09oRz5a8OowzWnKlVNRCGj5gg2XaVTEyqBF9uPq8He
         PX4A==
X-Gm-Message-State: AOAM5302jFT1fZu/MZ/hc2Kp4mgtvws3T5sS4ksTjKFbllUC4elqDhdX
        ZB/1WkSWX9EV3FF/HBzcDDwHD221qADkME034Wc=
X-Google-Smtp-Source: ABdhPJwjcv6WGVr4E5fbEOQrZ+mvHLUVksCQmvYUuNoNPvqvBRanv7Psn35XQ1i8X8/6ykn8yIUYtaqE4XU6vM4HHak=
X-Received: by 2002:a05:6512:2341:b0:448:2465:7cf with SMTP id
 p1-20020a056512234100b00448246507cfmr1552820lfu.474.1646879888550; Wed, 09
 Mar 2022 18:38:08 -0800 (PST)
MIME-Version: 1.0
Sender: malindaandrew731@gmail.com
Received: by 2002:a05:6512:151f:0:0:0:0 with HTTP; Wed, 9 Mar 2022 18:38:08
 -0800 (PST)
From:   "Mrs. Latifa Rassim Mohamad" <rassimlatifa400@gmail.com>
Date:   Wed, 9 Mar 2022 18:38:08 -0800
X-Google-Sender-Auth: hq0az3YdETkI9NsAHjkdgfi0lw0
Message-ID: <CAFJdX88VENEwBXqpagEviory3Oe-AXByJgGe_1Yo6g_iWHs7Uw@mail.gmail.com>
Subject: Hello my beloved.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_NAME_FM_MR_MRS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Greetings dears,

Hello my dear Good evening from here this evening, how are you doing
today? My name is Mrs.  Latifa Rassim Mohamad from Saudi Arabia, I
have something very important and serious i will like to discuss with
you privately, so i hope this is your private email?

Mrs. Latifa Rassim Mohamad.
