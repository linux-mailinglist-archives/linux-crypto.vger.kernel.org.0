Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C6F4D03C2
	for <lists+linux-crypto@lfdr.de>; Mon,  7 Mar 2022 17:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244027AbiCGQPN (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 7 Mar 2022 11:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiCGQPN (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 7 Mar 2022 11:15:13 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6AB3BA43
        for <linux-crypto@vger.kernel.org>; Mon,  7 Mar 2022 08:14:18 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id kl20so2720050qvb.10
        for <linux-crypto@vger.kernel.org>; Mon, 07 Mar 2022 08:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=c3P4r2Qz0VdfRBuStsXVpcJEgpWE5t0Sgi1SeeHIl+U=;
        b=BtvLFmkM7MnzsLyPIqEJn5Vd/bILDTYY/LHhmcNfwufP29QGQAASjVNn/ueSotmi2a
         zbY8bYYED8d+yBuXFobKA0H9LSb8fm7+3T69PvDDEMFVcn6Sb0kLbLwJhKKrckkq3rgB
         O3oApHvpJ58zw7p6HA6UqTUtO9nzvjQ2PQNMbqRHREBcovCW+bDHt+nxgs4acI1pt6rW
         DvSZXALVDO5A5bbnZYtcEhA/BYHR0s/d6+6OvWhDDe1GRP4e/IC1VbiGS26isayweQYs
         hW9HWTcE2UoEcE1OXVRS1JmojSwQizpaYN9un3k+J/hLkbv0853gA2ab8wpLOrixqUdK
         xc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=c3P4r2Qz0VdfRBuStsXVpcJEgpWE5t0Sgi1SeeHIl+U=;
        b=Av48zEKz29pqxGUGc0TUq8cBSIRXGixD3VfE5kLkmLlAGlOqpENJ7ltN2oE5hE3WPJ
         11dWA2rYJho5QCSCT/he6wDcUgcuXBi2ft9WVp4ddrGiin/304GXJ/dKxEWbhzJeqxFM
         9mef593j5Qi6yM63CiIytocCkZz596sXIuYhs590pNljeX0NjGmEqIdjknRz0K8vYnmd
         7LEIBbTr1bYuObA+oirHFCgD6lVRMbqhWbwoaSaCpwgRObgadZlKsdcfH4OagHGuYG8u
         n0MAP0Chh7nFbFxQgzmx4+a3KW1BIhRZCYiFOsjea4ym3fZRa032b8NMZqUmvKVSl3uQ
         UmeQ==
X-Gm-Message-State: AOAM532UVtZf49N1k3clnRIK3O73vHwpHcC783CIvt8PQ6NY9kTvnlv6
        BQ+ErVgZws9BlCR9Q8i+HyWMIMF5S/eFY7CFtJw=
X-Google-Smtp-Source: ABdhPJwqLfTUe2+fFTf/T2OXiuIb4RcetxxeLBydTavmMBOH6yUF0UYoGvp+XjW/ypLR3mZdmqtOqtxQ8Dds7L07jF4=
X-Received: by 2002:a05:6214:250a:b0:435:31d6:a18f with SMTP id
 gf10-20020a056214250a00b0043531d6a18fmr8592813qvb.72.1646669657978; Mon, 07
 Mar 2022 08:14:17 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:622a:1354:0:0:0:0 with HTTP; Mon, 7 Mar 2022 08:14:17
 -0800 (PST)
Reply-To: fionahill.usa@outlook.com
From:   Fiona Hill <fernadezl768@gmail.com>
Date:   Mon, 7 Mar 2022 08:14:17 -0800
Message-ID: <CA+J-fD52vy+SuJ5kfqKCt4+dN007W7wsmVK+Q7KembE8pkxa5w@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.1 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

-- 
Please with honesty did you receive our message we send to you?
