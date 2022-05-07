Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F9551E8B0
	for <lists+linux-crypto@lfdr.de>; Sat,  7 May 2022 18:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238286AbiEGRDH (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 7 May 2022 13:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbiEGRDG (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 7 May 2022 13:03:06 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BC811A1A
        for <linux-crypto@vger.kernel.org>; Sat,  7 May 2022 09:59:18 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x18so10210585plg.6
        for <linux-crypto@vger.kernel.org>; Sat, 07 May 2022 09:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=5vqN6t3JU5DyBeppSoCvHcP38qUC2msIwHIXAHopaME=;
        b=KvwV2pTznpc+1piYUIgfAw8ZVyAnxYol9UJLgS7YrO938Fm/NZ8dBAetMKb5Y7V91e
         D9fAiRL3wSczqIr3vByPCpZOlK1BT5PVGJAZUXHanPm3DPFZSsS6U+E6b3lVSAf/2ETF
         F4ETP6DGiPIr5TRvysB9VHVd6K5SxxPVhKAZCMRIQZGEtW8OnihCrRfX7xfel2hkNcKm
         oz0mf7eG9WVzwr28vB5qkHxoYWYB2tvJAvudzU1U+TuENxgfqtyC/y1OgjzYT4u0cAcd
         8v1Hewtz5oF0fw6Ru3VjfYdsGe1RGORWbPSdP3P41W7PuP8+n724IESbpIyViM/8cxIf
         zTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=5vqN6t3JU5DyBeppSoCvHcP38qUC2msIwHIXAHopaME=;
        b=DasN7f43Mr9Qt2WlgmJN0J6K073JsalMC/psfgucRWrn99kwvCG/Jk/N7Iscbvs5HP
         k53n/ZU6VT8jtQVS2DFfUCgKWJlQcluX3u3+aQ37L2R/J5WpPDWpRo9boEzkt1dWeh01
         61uPfBoS6L+Kbadc7510AjAI6vwRg33fuvJUIEMMWK7eAPU2dSPcvVTwK5tCHHs+ed1N
         DhNeYgWseVJlITZxZD5dKvW+kEGD08knv4opB0NTCwdj4N7XrzaRs/v/qRw44ReXGDTE
         C/TcsFz1oFRorgBadUkq3e0ZCqO/pdxw+W73WDc/k1YfCUl03PvEL/XvqNzdmxi+3kyf
         57Yw==
X-Gm-Message-State: AOAM532X2dKgg6aofemJhYmiuGdhSlTFIyc7ZpZvyu59wLtIKHKaYGpR
        ztNbexwbqDRAM504e5zn/lrFyYK+u+xoXETx0Wg=
X-Google-Smtp-Source: ABdhPJxqyk8zzFVAs8pUkb7hL5rBFCoNSKuHqF5RfwLJoufcODgfpjCf6rdeFrCvRQtditjZjbgFMibL7BlwlQlQPo0=
X-Received: by 2002:a17:902:f542:b0:15e:b6d2:88d9 with SMTP id
 h2-20020a170902f54200b0015eb6d288d9mr8738800plf.128.1651942758133; Sat, 07
 May 2022 09:59:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:ae98:0:0:0:0 with HTTP; Sat, 7 May 2022 09:59:17
 -0700 (PDT)
Reply-To: rkeenj7@gmail.com
From:   "Keen J. Richardson" <richardsonkeenj@gmail.com>
Date:   Sat, 7 May 2022 16:59:17 +0000
Message-ID: <CAO5iNP53+gugaAn34QtyewjMSS1dgtS9hr=fu+8BMKmjcE5Fjg@mail.gmail.com>
Subject: GOOD DAY
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:644 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4838]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [rkeenj7[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [richardsonkeenj[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

-- 
A mail was sent to you sometime last week with the expectation of
having a return mail from you but to my surprise you never bothered to
reply. Kindly reply for further explanations.

Respectfully yours,
keen J. Richardson
