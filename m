Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9175B6F99AF
	for <lists+linux-crypto@lfdr.de>; Sun,  7 May 2023 18:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjEGQXz (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 7 May 2023 12:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjEGQXy (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 7 May 2023 12:23:54 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D1812082
        for <linux-crypto@vger.kernel.org>; Sun,  7 May 2023 09:23:53 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6435bbedb4fso4041009b3a.3
        for <linux-crypto@vger.kernel.org>; Sun, 07 May 2023 09:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683476633; x=1686068633;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a0ecg5KC5wMELpv5KoMWwexl88AAqVKm+usrtL33ouU=;
        b=nry2MxpqBNiHfLtOOQ5hx6+ss2tM2Jdlensu6w0hzRdrPnnA85J15fInuhpnMheR/C
         OMIJm4dv91V96Bh7zXvNpkQWjVhNC2KeT89nZzmmnVJiA5N5OSKbbJXCG57prA3rx1XE
         HNC01BH+CnXS9iLHNc2dOH3itKXVyDCe8k1hWzSW/PU4C6nLgIKbFwuCnMiNOYwVoXJ2
         xw6xYKNKvd2CSmtIhVT4AXvSORbdz+0ZYbk9jJUcPkZTVF1oWboX71spyYIWYHp+KXnd
         jzAHI1ZBlpipr0vDjCB++zSrKlcNpheK5BhqVuYDeHcYqGjqi529dIzVAz4glo/SzA8B
         tO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683476633; x=1686068633;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a0ecg5KC5wMELpv5KoMWwexl88AAqVKm+usrtL33ouU=;
        b=J3fQlHwxAoMzjHydOaAiZlVgmMcnfzP6GKjRGt+hDlVcO1on5VSZlgPh63xVcHQyP/
         oJcpSvJ2nNWSA2HEW0/CsKxf5KAg4sFRm464bmr5G7frg9JrWSfjzQVJP5KyV8V0aitt
         Yr3QblEIF7m93nwNifKenxKKzJQa5zuaKv8XQndXxtXcGp2xz1noidkCnTNbYi0Bhng7
         Pqj3FHfafQxXtRKrd2vy54Grd3oWpR84jYZlKoFOi3l4hPmiznpOYfRxD/reLwTABK55
         BaTSR4fGTSWYqmxl4QiLV/N74xziC/OE69vB324o83js58hG5p+04A0EjhLOQxmsnH57
         Hl1A==
X-Gm-Message-State: AC+VfDwzGaPDW198zZtES1ncAGvTU9NNntiCGkCPWjCWG5tcC+iTE1tP
        uR3r+mG5TP3FaZrVrV/W6d99T9Q+8t0DijQ1Lxc=
X-Google-Smtp-Source: ACHHUZ4Wcky+qSKBD/eTWBNYYB8JhtePcodBVRJrMXZTZBeL3GyDOE2g/Iosh/58iQDLt2vEBB7PRlffuQDT5goyvBw=
X-Received: by 2002:a05:6a00:2e05:b0:63e:6b8a:7975 with SMTP id
 fc5-20020a056a002e0500b0063e6b8a7975mr9152032pfb.9.1683476632252; Sun, 07 May
 2023 09:23:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7300:23c7:b0:c2:f214:9a9f with HTTP; Sun, 7 May 2023
 09:23:51 -0700 (PDT)
Reply-To: wormer.amos@aol.com
From:   Wormer Amos <amic22799@gmail.com>
Date:   Sun, 7 May 2023 17:23:51 +0100
Message-ID: <CAD5jw6pjcE+OvqbT+h_RBEiPtfqUN1M6zbyAZUg9D-RBJgZazg@mail.gmail.com>
Subject: FROM AMOS,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:42f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [amic22799[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [amic22799[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Whats up. please i want to know if you're ready for business investment
project in
your country because i
need a serious partnership with good background, kindly reply
me to discuss details immediately. i will appreciate you to contact me
on this email below.

Thanks and awaiting for your quick response,

Wormer!!
