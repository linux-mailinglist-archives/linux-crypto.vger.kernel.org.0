Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D7D6B75DC
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Mar 2023 12:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjCMLWC (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 13 Mar 2023 07:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCMLWB (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 13 Mar 2023 07:22:01 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E007EFB
        for <linux-crypto@vger.kernel.org>; Mon, 13 Mar 2023 04:21:58 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id bf15so4844983iob.7
        for <linux-crypto@vger.kernel.org>; Mon, 13 Mar 2023 04:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678706518;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bgEHIWNKONA4yueZUvZBaRo0OnzFlmsySmjtgcP7fj8=;
        b=on0sDzimDSQlGXIZ/8+guhRf/+GSlepvyPH0BRiKeA6MqOqZxRP6rPamUMrlVsXTvL
         YhBPZKNUnmfDfM7jlvqfoBPCdj6d/XClM7fGjwCgG6LZa+/q8n+XXGwfctckO/5pz2Q5
         mSgZseVkbo1wZp6yYNW8Pt0d1EtHdwcL+zm/ZpX+gE1ERgSvqI9Et78twuuxpoKdlOMB
         HH5joTIelDSlYvQBjWXVwEDM+eTtULRlIgZXhG3qRk8DyB5Y+7aZEfjJOyxxwCa40CbV
         kBWeyugk6jEx6mnEYncMTQe6+mremyYNF2mxoAd5voxxpgeMuA3goaKpDxLTStrSz4TM
         rXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678706518;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bgEHIWNKONA4yueZUvZBaRo0OnzFlmsySmjtgcP7fj8=;
        b=1x91b2ieAvlqJEK9spR5SuP2c9otRMzWS5t7AhnDMyv4EX+qdsk+h6I5x0m6HICWPx
         9P9s2Iek+//DP1xD+bBzjtrzufeUhE4HfnIXp3RFuw+wM58ix9iEePdguG4VzR0dxbfu
         wbOmP9bLQbxJhPTxsEHS9Gbcb94DxY0IBdg8sy7yXygWYdeibFhU9BP2P+O9110eboW6
         ckJoa4UejPxnNhptFXUNwsRT8+b0Lh9Xf7Li5urpRz6DlQ0W1q1dkvVJEuk7bmHeucr4
         UrU2HllujK3nz4KcQ1/czeAaAsoS7wkVrr34Xi4+1OQGC58lXM8U2CkzHEv/R97ghKPX
         NM6Q==
X-Gm-Message-State: AO0yUKW0PybeObs+5zfGoMGWTUbZI9QwCKyjDAKw/HT5yI1zjYQNlNjD
        jIp6+GQtWFYMV1qzLdf5I2hugZzVDOZ0l41gThM=
X-Google-Smtp-Source: AK7set9hvxR1dKb80l8ZCcLTVcEDb6U1Y8/kUDZ5KhEM7XEAQx6gdp4zd6edHTvOMVJ6t7MHP/r+8pc/3SS0NUBn+lk=
X-Received: by 2002:a5e:c10f:0:b0:74c:7caf:8edb with SMTP id
 v15-20020a5ec10f000000b0074c7caf8edbmr15347730iol.4.1678706518139; Mon, 13
 Mar 2023 04:21:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:aa8f:0:b0:39e:a318:1e0a with HTTP; Mon, 13 Mar 2023
 04:21:57 -0700 (PDT)
Reply-To: elvismorgan261@gmail.com
From:   Elvis Morgan <bhufhi586@gmail.com>
Date:   Mon, 13 Mar 2023 11:21:57 +0000
Message-ID: <CAG=zD6YTdwc9HkS95k9oE8CpuEJeM95nYqeWNPW_gU9nTnOW9A@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:d41 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4997]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [bhufhi586[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [bhufhi586[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [elvismorgan261[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

--=20
Jak se m=C3=A1te?
