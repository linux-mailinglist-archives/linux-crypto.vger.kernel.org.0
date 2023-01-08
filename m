Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F20661473
	for <lists+linux-crypto@lfdr.de>; Sun,  8 Jan 2023 11:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjAHKFH (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 8 Jan 2023 05:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjAHKFG (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 8 Jan 2023 05:05:06 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068E9DE87
        for <linux-crypto@vger.kernel.org>; Sun,  8 Jan 2023 02:05:05 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-12c8312131fso6093490fac.4
        for <linux-crypto@vger.kernel.org>; Sun, 08 Jan 2023 02:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FocuR5aXn3z28LzYD0rCmA/t4By4lcIW0G986gs+i74=;
        b=JED/yjI5fAfF4Q/+8t/rVwU4RT3SKhSLcV1JT1iOWC0CY57g4BmE8pU+krUEfVosHN
         gP5z6y+CwlQul0oCySTCprPSvKNTtFd9N+LlvmnteIm81F2ep+m877wmVZqnAwEYuXz7
         4obEZKxKB8npHwVuUcrxT71YD4K8474hKg/K0dyiVjgQkJLergZ1Xpl1zno8OpWf0X5N
         r80g4q0Wmgv+uNQdo9cJTYpghohMtNhDPnNDY96dtDLUrjuFNUS+6JwxROf5CkZ7PL/7
         1GTG76zZqGyEdzhMoqfd9dT46VVcY5GbvxX2bf5hRzFwyUhmdXwEIsSk018zf+csIr/Z
         +IVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FocuR5aXn3z28LzYD0rCmA/t4By4lcIW0G986gs+i74=;
        b=EhVrLbuwOGT7sNaYm6z445ce6tQvFs1faIdOq9+u1EsYBD/h1Blqfd5z3K8ZYubftP
         nimZtsJKXaW+/t0I1BopfnQoCvxU1XHlYkZz5WApr6I5+L+lOCZ+5EnCGrLhHO/t5Zb9
         ut9ob/txi8gU0Y2ff5+7ib+IV7lgqUb2yXE0XHXy2dvehTojYPJZ10UdCGxe7FXo+7fX
         HRiuLQIcGQcM8dN6bwf+GTzNfK8Qv8N4uYvdtDX5+FSqgOd1orTjP5CCyr0k62VLDjTR
         omlRC+2DwgnEMcQtTP110AOSDFXJTKA/Kdst+W5BbPhuQggUEixlF/CRp9b6MQmoJxTH
         S5+Q==
X-Gm-Message-State: AFqh2kpw85kcW3XZQkKW61wQrUAh3EUxTNxozOK5KVhSeiCFanK71lpZ
        4JqqCSSZk+Cd5IhJIR0zikOxc5heZUAq8ttMzk8=
X-Google-Smtp-Source: AMrXdXtbuRyr58ybVnSL85S+oZHWIYjmU+RozTgGz0IRDYqZV7mxhHj0onXPPqU5iyi805XmPb2nEVHmgENaZQv7Z/k=
X-Received: by 2002:a05:6870:35c7:b0:14c:8198:e971 with SMTP id
 c7-20020a05687035c700b0014c8198e971mr4686371oak.269.1673172303530; Sun, 08
 Jan 2023 02:05:03 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:752:0:b0:499:f0c7:435a with HTTP; Sun, 8 Jan 2023
 02:05:03 -0800 (PST)
Reply-To: khalil588577@gmail.com
From:   Abdul Latif <huntingtonnationalbk@gmail.com>
Date:   Sun, 8 Jan 2023 10:05:03 +0000
Message-ID: <CA+idcZFotNzFQSOPKxVSBf4jOAXUt5chjzzCFqL+kJZ46JW4dQ@mail.gmail.com>
Subject: GET BACK TO ME
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:2a listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4872]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [huntingtonnationalbk[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [khalil588577[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
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
