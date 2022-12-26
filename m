Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701C765623E
	for <lists+linux-crypto@lfdr.de>; Mon, 26 Dec 2022 12:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiLZLrN (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 26 Dec 2022 06:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiLZLrM (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 26 Dec 2022 06:47:12 -0500
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8251A2FB
        for <linux-crypto@vger.kernel.org>; Mon, 26 Dec 2022 03:47:11 -0800 (PST)
Received: by mail-vk1-xa2b.google.com with SMTP id 6so4892261vkz.0
        for <linux-crypto@vger.kernel.org>; Mon, 26 Dec 2022 03:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FocuR5aXn3z28LzYD0rCmA/t4By4lcIW0G986gs+i74=;
        b=HIvJNviIlXD0ZOi1qksjfEyv3svlIuyNU2fwNW+lt86FCV+oASVt+lap9uMnO4G2oY
         Ffe2Z62yaaeQ54WLtd4Ixck9dNCTOCk5JLczlp/51gvpxgBY+miksTMK11g0XJvy32/8
         oh2YwvBDt0Ao+3adktzcvEjrE1ICk8IxiPzWmz8MJ62Q9sAXh3ic0Os8RVyYElTqDLVS
         SnZNnMCHN1CBaVQ1TyoGNORYMqTfx7VblTPxipkq4j9sqym/YGW/bImTArQCxxmj0CMm
         LEaNiUIpz3AscEq3oXOFL2y8M7vUlSs5j4b8crIZuNLYl4ksjZZ8FpxjG+lOBvHhz64v
         un0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FocuR5aXn3z28LzYD0rCmA/t4By4lcIW0G986gs+i74=;
        b=cUE/2XNK5tr8zgVr1sWM7wE1XWsShM8mqHAH6sH+Ka91k93p1w10+11kWGg2uxHLsu
         k7kxNDb7CwATEHL769b+dnwn6O5laV/fUWWOvGY4fOpicTxGzNYyzCPSGXtaYltYSzVG
         +lumgOoO197PH3Bpg5cKPyZWrP8TQep6C7Zi6S9CtOFn/Su20xGXf89e2T9k3o0ypZIt
         YCh5NmmgYutoe5x2phCYQToLNcJ0hF7RPtfJtV20lP9G1Q/dhdDXG4o1jdidRqe9wY7N
         lrxAjf1a173QK6tbAtcVy3lfietqR/U6zvGKtdrW1bTUxO/u4RSz9ZdoCnRSiu4ya5hJ
         3gEQ==
X-Gm-Message-State: AFqh2krUNiWQkwPbYdIpjMqSyGeLNcKs23p1EjbIaRzAgJXOKqPdZMcu
        FxyeBKBCaXEWsbwyeNlYsaKnUCOUMKClGAcTatE=
X-Google-Smtp-Source: AMrXdXs6JAJfGLHPBTV2OjKVl1pH2qn9oXdrv97h/zGspK40334Yg+/LaPgwlmJRU38BNELIrkbBBFSnaSE6p3s4c0Y=
X-Received: by 2002:ac5:c5a1:0:b0:3d0:6083:f515 with SMTP id
 f1-20020ac5c5a1000000b003d06083f515mr1843232vkl.6.1672055230143; Mon, 26 Dec
 2022 03:47:10 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab0:718f:0:0:0:0:0 with HTTP; Mon, 26 Dec 2022 03:47:09
 -0800 (PST)
Reply-To: khalil588577@gmail.com
From:   Abdul Latif <tahreem.hassan1960@gmail.com>
Date:   Mon, 26 Dec 2022 11:47:09 +0000
Message-ID: <CAGwT3UW9_akXjY9CqJe8hLzZjdzYKdPKPRY6cWyjs0FPHgKKZw@mail.gmail.com>
Subject: GET BACK TO ME
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:a2b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4980]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [khalil588577[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [tahreem.hassan1960[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [tahreem.hassan1960[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

I am Mr.Abdul Latif i have something to discuss with you
