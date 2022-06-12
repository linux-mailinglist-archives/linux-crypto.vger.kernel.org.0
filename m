Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC27A5479EC
	for <lists+linux-crypto@lfdr.de>; Sun, 12 Jun 2022 13:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbiFLLcc (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 12 Jun 2022 07:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236375AbiFLLcb (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 12 Jun 2022 07:32:31 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4278229CB0
        for <linux-crypto@vger.kernel.org>; Sun, 12 Jun 2022 04:32:29 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id d14so3908491eda.12
        for <linux-crypto@vger.kernel.org>; Sun, 12 Jun 2022 04:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=9FfohXFhB1sP403VxH1swwcmiEO4r97TnueS6gdgla0=;
        b=HutqJca9cz10+fhpLBqF5pkCfmNuVpB/QmLPLH2RoeSpp+88FPj9DCRLsYlrV60IRI
         yfGt8kTQJ3+U5hD05c9eQjOTUDndc3kFmmCKtoZcJTw6iEXGeaPRZUwBIb2hL10aHe3A
         7EbObtS3e/RUerZDq6P0if6rMoEsasBL0IeuLIxwTHpNu3CceyHT/j7BTvAXuGh/jXn3
         mZ2PnrRRlC0NrnYO4yqGRbm/BexgsBU/ybIJL5KQreT4XiaErEnB2fMcohiz3+qsoqp8
         Xl5GKvTeAgRog3ZkHFVKaziM00o+HwG/FDCDlODVc32UellWfe2pLGmko+Rt8jRhNdyv
         b+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=9FfohXFhB1sP403VxH1swwcmiEO4r97TnueS6gdgla0=;
        b=4LzgdZZ61BwShRDH/6LNIzRTbeas8AgPTN8TyNpEJ/WmQzhoX84QjQh1QgEdIT/HkY
         wKlcX0ZaAttMOVa9QqML8GDK7qyf7DTnqTahOngJrP3RkPiknAMRmDoygvIPYZwRiELC
         jWo/YfVAb3C9zweYdA5zhxaF0ooEzM+edZP0k4WjrDf8wQ7OcE2wxHg7q1LaFoGUs0pv
         up/l92pN9dCg4ILKjB6aP0WpBtIfZ6gUTBt8YFSLAENxBoYI3FCVhKaUZkJDR+b+SEjN
         JxQ8S+lW4UpRU+ZEddhWqLszIxPt9lUuP6KCcZbO4c+IEyGu4odLp74lBQXKTYzpKIa8
         3AGg==
X-Gm-Message-State: AOAM530ShsW4RZboPo8qpU2SCzdOWX55Tbh776uF1h6mrwo4WRfnFYep
        roFM6nVH5KFyQUGbU19dz+85F5v2Jxsnk/W2rnE=
X-Google-Smtp-Source: ABdhPJwdx/ts4yT81TfY9H4jSVwEQwJ2e/fPBdkfFmfsPIbmOM0FEcnF1voZtHMiIfkmIVV3xB+6Fmj8j1iYk6t89oo=
X-Received: by 2002:a05:6402:d05:b0:425:b5c8:faeb with SMTP id
 eb5-20020a0564020d0500b00425b5c8faebmr60549161edb.273.1655033547542; Sun, 12
 Jun 2022 04:32:27 -0700 (PDT)
MIME-Version: 1.0
Sender: mariajohn0331@gmail.com
Received: by 2002:a54:3a4a:0:0:0:0:0 with HTTP; Sun, 12 Jun 2022 04:32:26
 -0700 (PDT)
From:   MARIA ROLAND <mariaroland74@gmail.com>
Date:   Sun, 12 Jun 2022 04:32:26 -0700
X-Google-Sender-Auth: Co32K8Guj2mgf2O-dHQRzwqxqMY
Message-ID: <CAEmdD2WEq8iFu03odoUHJOLqaAfOodUu9x8Et1FumwjSBv0eHw@mail.gmail.com>
Subject: Greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_60,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:536 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6902]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mariajohn0331[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mariajohn0331[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  0.6 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Greetings,

I sent this mail praying it will find you in a good condition, since I
myself am in a very critical health condition in which I sleep every
night  without knowing if I may be alive to see the next day. I am
Mrs. Maria Roland, a widow suffering from a long time illness. I have
some funds I  inherited from my late husband, the sum of
($11,000,000.00) my Doctor told me recently that I have serious
sickness which is a cancer problem. What disturbs me most is my stroke
sickness. Having known my condition, I decided to donate this fund to
a good person that will utilize it the way I am going to instruct
herein. I need a very honest God.

fearing a person who can claim this money and use it for Charity
works, for orphanages, widows and also build schools for less
privileges that will be named after my late husband if possible and to
promote the word of God and the effort that the house of God is
maintained. I do not want a situation where this money will be used in
an ungodly manner. That's why I' making this decision. I'm not afraid
of death so I know where I'm going. I accept this decision because I
do not have any child who will inherit this money after I die. Please
I want your sincere and urgent answer to know if you will be able to
execute this project, and I will give you more information on how the
fund will be transferred to your bank account. I am waiting for your reply,

May God Bless you,

Mrs. Maria Roland,
