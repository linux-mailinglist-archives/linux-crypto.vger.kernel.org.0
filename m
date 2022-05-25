Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F49653452D
	for <lists+linux-crypto@lfdr.de>; Wed, 25 May 2022 22:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345189AbiEYUmi (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 25 May 2022 16:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345179AbiEYUmi (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 25 May 2022 16:42:38 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14B3B0D15
        for <linux-crypto@vger.kernel.org>; Wed, 25 May 2022 13:42:36 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-2ef5380669cso227028937b3.9
        for <linux-crypto@vger.kernel.org>; Wed, 25 May 2022 13:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=LDBqQh/PztHeiDiV9Pr0v62BTTaDnPQyU98FGi1REkw=;
        b=qXByR7EufpzoGQiN06MDPIVWzdylLG3o46SZpFvmALD7dQ/PgjHu3dAOdG4vHKIlfe
         o4pnFLvM6qO7tfMb32rqQxgUNzZp6gdeGFDkaYnNu/L384UihSeFla/OCMwsBAF3705g
         aoIOUM85zZmqEG9ecsktReRuF0D56BtsybiDVuBWXKXg1j5P64zJQv9Dpj1ReV3CPl4j
         5alt292Xc+TmQmAS9PrcySvzwaZnTkvZZdWEtMf296xtKREeKQCGVfeCiibW0qnTX9Qu
         7bEy8jEeJHs+TVn/2WvP0NanfefW/JaGuBcJU8L63BJmai1/hqD3u/byWhupBBZYSYoU
         /IYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=LDBqQh/PztHeiDiV9Pr0v62BTTaDnPQyU98FGi1REkw=;
        b=lkZ4G61fvzHCOgUjSUT2cEqmHrJbCWWF6qvAdDVGoA2K1HW3NTvoa9ocHlu+S/nJr/
         M27nFuWp71YETZXrzNVvj0CYIr5m5M8JpEeFgyDFWo+O0xdxLv6/Wdcp9PAFR8uDvhiG
         ZdSsu3ajAP7SREm0jHhs4vQnrhRidhPEgryOJo9EqViZZpZz3UqjTDChtVZ7FTMHJO0v
         tBVR8nFkiHRaWfk98xT4MJhQsUwKVG726F93DszzZYcJ2NvUE2wumZy7YxW5+rH0hrGB
         Vxon8/U89MNyqYFJ5PsJIGx+cquDFv0JhMWpGn7IOSXG8MEPLu9YDuuWFR2DsWkQsVzq
         iN3A==
X-Gm-Message-State: AOAM531RsEbE/JZ5MSLw9LYj5cXw6URkRArEFR1Y0nfY5vZ7X/7K68AH
        nXIsJDvI82cvZNqRlOdpgoUjKZs6B3XH8izW5hI=
X-Google-Smtp-Source: ABdhPJwSy9gIL2rmC2eVlR4qYfk4gjTw3/aO1KuvySOFfkgG3DuJQpFytIvDDKuHulBchsUQTaGwWGCGNDaLcVgEOHA=
X-Received: by 2002:a81:7607:0:b0:2fb:7bee:bf70 with SMTP id
 r7-20020a817607000000b002fb7beebf70mr35495161ywc.279.1653511356175; Wed, 25
 May 2022 13:42:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:506:0:0:0:0:0 with HTTP; Wed, 25 May 2022 13:42:35 -0700 (PDT)
From:   Deterin Falcao <falcaodeterin@gmail.com>
Date:   Wed, 25 May 2022 22:42:35 +0200
Message-ID: <CABCO4Z1qRyNfOn1xz1AEWfgUaQmSXp-LftTWBPBTfu+NB_4BTA@mail.gmail.com>
Subject: Bitte kontaktaufnahme Erforderlich !!! Please Contact Required !!!
To:     contact@firstdiamondbk.com
Cc:     info@firstdiamondbk.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Guten Tag,

Ich habe mich nur gefragt, ob Sie meine vorherige E-Mail bekommen

haben ?

Ich habe versucht, Sie per E-Mail zu erreichen.

Kommen Sie bitte schnell zu mir zur=C3=BCck, es ist sehr wichtig.

Danke

Falcao Deterin

falcaodeterin@gmail.com








----------------------------------




Good Afternoon,

I was just wondering if you got my Previous E-mail
have ?

I tried to reach you by E-mail.

Please come back to me quickly, it is very Important.

Thanks

Falcao Deterin

falcaodeterin@gmail.com
