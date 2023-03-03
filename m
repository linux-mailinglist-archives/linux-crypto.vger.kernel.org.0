Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063A66A8F00
	for <lists+linux-crypto@lfdr.de>; Fri,  3 Mar 2023 02:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjCCBzN (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 2 Mar 2023 20:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjCCBy6 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 2 Mar 2023 20:54:58 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9ACC211F3
        for <linux-crypto@vger.kernel.org>; Thu,  2 Mar 2023 17:53:59 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-536be69eadfso17271917b3.1
        for <linux-crypto@vger.kernel.org>; Thu, 02 Mar 2023 17:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677808439;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YxWgvIJdD6AE8Ce+eEDzrC0gSnd+arQ9utE5ORXuyI=;
        b=ROCCEQa7kpCGplRxxd+TpKCz4GWvlgZ00szyZII4+P46zWJKrFrlLzYWu/nfZyiLRp
         o5NIZvKAr8//25S0cH+8DlIeiAXMEIW/Sd0uiAB9FeygLZh/ise59k5sZOu/q/mNrsvE
         QvF980fkZgp6n+nOGwwkAwxazNe/u1YangYISZ28+mbFRJ6+7xAQH6pr+lThLgzT3Ozw
         zxSOOLbIGIjWk8lI4CJrPEVS5gyybvgl+YHXdAQo0int72cJobIABu1mCGjP8xY1Tngy
         xD4DpsxzujwBqBKgn8+47Z5b9kNU8cIB6RpW6up7pc+vqY4nkC0nxNCQFM93E3noMJC8
         MSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677808439;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2YxWgvIJdD6AE8Ce+eEDzrC0gSnd+arQ9utE5ORXuyI=;
        b=OxKk1TuNus7dPKCYmpitpbXdYA/xCv95JsmVQ3mFUoZFvTcqTpfuDA9sU2LcefM/2c
         Bom0utX9+gX7YN5jSoqRG6qQV2iU+HjJdOv/ZTpoesLVM6c1AFm0yVy6jBwD/XggqQvp
         rCd7G1Tk1sNbQSckbL01pyPVWivPdZmWLKDyFpRGl9evhbmAYUD+XPX6cD/FOXet+jQd
         o8U24LwqbaITNaDwGCsavBZTc/3PhLkrl0ckcAvq3O7ZEV/SMfNiiP87lnvgarLfdK7X
         5WxjLOvEWSDMWAt2lvH+d5QGQydio1Lt5sYMA07nDqHPaCllZWiQgd6ZJTbIoq4PcPx9
         KixA==
X-Gm-Message-State: AO0yUKXYpC/+lN87aHG2Dq6nJvLVbxT9f1v1Pkbk4ZUZMxrxtAr2To0g
        usbMmGlgKhAqRvK1ghWmO8rzhkg/QjA8Ts0J/6BokGmVhQU=
X-Google-Smtp-Source: AK7set91BvVFYXxC2sroF6S+n26ny3rGGxpt0P8Yhi381MyNQkNw8Ry6M8JSN9d9oDIISmoHv3kH6WCIqxRAEF0mlA8=
X-Received: by 2002:a81:b664:0:b0:52e:c77d:3739 with SMTP id
 h36-20020a81b664000000b0052ec77d3739mr7525343ywk.9.1677808438904; Thu, 02 Mar
 2023 17:53:58 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7010:44cc:b0:305:7c10:3783 with HTTP; Thu, 2 Mar 2023
 17:53:58 -0800 (PST)
Reply-To: elvismorgan261@gmail.com
From:   Elvis Morgan <tinaevan009@gmail.com>
Date:   Fri, 3 Mar 2023 01:53:58 +0000
Message-ID: <CAGMdNs16cTyJiMm5T08jP_K2PwJ-CBtiMPKRSALXWpLJTwpiWw@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:112a listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5843]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [tinaevan009[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [tinaevan009[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [elvismorgan261[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

-- 
How are you?
