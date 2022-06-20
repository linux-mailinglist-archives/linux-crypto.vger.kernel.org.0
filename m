Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033215515A2
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Jun 2022 12:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235339AbiFTKUL (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 20 Jun 2022 06:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238836AbiFTKTz (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 20 Jun 2022 06:19:55 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3CD13F6C
        for <linux-crypto@vger.kernel.org>; Mon, 20 Jun 2022 03:19:53 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id g15so7454958qke.4
        for <linux-crypto@vger.kernel.org>; Mon, 20 Jun 2022 03:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=gbajSp5YCVdFafZdV+A6RN5AOmWOkoW1+ZuvrCNuICI=;
        b=q2gAy4ZAb/couy7rb0jTEuw3JkKece9V32uJ7voORRPVu7FmHRW4ejUzTp7SGk+vGu
         AxngIgslVpHSmyTvXOeOLiBXud1UJAMgM4MRGxpHHzJN1kfFe3LP+amhf2MA3IKITUlP
         V+bKWB+K/i8/u4kt6U8eeKl/Ok4JpUkn8HoHq+h/jGyBxs+qHxNOC94vuctdJiE+0n11
         BQcE68ZFCkyYpfeTDiK43AUL2ekE49vFuFOXUXZk1uymZxJUkrDkSlPVNwH+ChG1yhIj
         aYwW+c7FfZu/PkQ43iJr5wbkBvB58L/B9TVayeAnn9mWBgN9RTqfBJZsJ1Y7NJZGKl4d
         1iCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=gbajSp5YCVdFafZdV+A6RN5AOmWOkoW1+ZuvrCNuICI=;
        b=QkwLhdRexcd1u9gLnOIoAvJ5ibav06JbWsxMEr6/4tQBjxg1avmqHlwKdYrQG7oYn3
         FxiTP6aI/COCsnmB3/Vmj51/h3HjfL5J3fuwKUGpNIe4dYl7p9rKMotzk/744vnT5wj8
         sTOk/ftJLK1RsxyNWolAyFMnd/CaRxTx5LXrJcPMZ/m/8ttqYHPicROMFJ33dTBu1AAo
         j32+9xM4+jIVV0WJh8aiv7Y2KZ50sGSDz6Ep6ic0IjR7FcwOYKbelPPxionOWJeV/FM7
         RmC72lBZHc3iBC2xe6cSn2ONrl/4c+pTGUcUmA5ZR8MyhsYnEjvqa90ZgQq3pCkqgb5f
         qAQQ==
X-Gm-Message-State: AJIora+R73d/C1H9PdeRfuyAKj7pP9PQAO0cTV+9M+kFE+ZaKEN1nArd
        9pprw5OAlgNz/+k+DEfWgSnvhkfWEiodgtXFeA0=
X-Google-Smtp-Source: AGRyM1vKwUJDOAy0LAcJZAiran9I+vSWalX1PI/+qHZD+pHpQBCdOBkZXPi/8Vjp/7IiobZAuAH3d06h/eV8ZozmSFQ=
X-Received: by 2002:a05:620a:69c:b0:6a6:b662:6fb with SMTP id
 f28-20020a05620a069c00b006a6b66206fbmr15633652qkh.728.1655720392415; Mon, 20
 Jun 2022 03:19:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:622a:1741:0:0:0:0 with HTTP; Mon, 20 Jun 2022 03:19:52
 -0700 (PDT)
Reply-To: v.muller@sodilec-distribution.com
From:   "SOCIETE D'IMPORTATION LECLERC" <cjvdistribution1@gmail.com>
Date:   Mon, 20 Jun 2022 12:19:52 +0200
Message-ID: <CAHabqDEu9UkcYXtt2-kC5Z-yA96snuLgUcPSTrq+cHzdvu7-Ow@mail.gmail.com>
Subject: COLLABORATION.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.8 required=5.0 tests=BAYES_50,DEAR_SOMETHING,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

--=20
Dear Sir/Mme ,

Can you open a pro customer account for us ?
Our quote request concerns the purchase of your products.
ACCOUNT OPENING - 7 Days from date of invoice.
Do not hesitate to come back to us for the next details.

Cordially.

VINCENT MULLER
Sales Director
Tel: +33780934407
SOCIETE D'IMPORTATION LECLERC
26 QUAI MARCEL BOYER
94200 IVRY SUR SEINE
N=C2=B0 RCS : B 315 281 113 ,TVA : FR37315281113
