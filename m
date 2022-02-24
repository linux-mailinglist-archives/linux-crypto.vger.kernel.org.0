Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A624C209A
	for <lists+linux-crypto@lfdr.de>; Thu, 24 Feb 2022 01:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiBXAaz (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 23 Feb 2022 19:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiBXAay (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 23 Feb 2022 19:30:54 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662086D87D
        for <linux-crypto@vger.kernel.org>; Wed, 23 Feb 2022 16:30:26 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id w3so645315edu.8
        for <linux-crypto@vger.kernel.org>; Wed, 23 Feb 2022 16:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=zI3YMoABJRyR+odt0AbJrQOCfTLDDuwNt2ksIU5nkFY=;
        b=j1mbwNRl02UfyWj/KJ1FJYuBD+F0ebljU0ZfVaQsC3NfNeU5jsMV3eqeMoy0ZNY4N4
         4Y6m4acvn4OY4ZI1WCvv1VR0F7Kd5JB0eKmO4U27nVy4u0Skt1AcdlLg+1QlqfDk7pAH
         1o9B0POdP8cNZ8Vz8zKc4RBW0oBJz9wI3qdJhKntFJGezrcxzXwufmja1VNJndpZ0aP7
         mm185FBKwBoDjL/0+H5zS+rPAkyUWiZitWd8gTQ2monwEHjkEyNuqcTPO2+bFgf1+zG1
         MuikoODPumLHaAruE63Tcpeb3c6p566vsL3r3+Hezr6HEGreY9+sNQTYSBPgvQgvqPb2
         gMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=zI3YMoABJRyR+odt0AbJrQOCfTLDDuwNt2ksIU5nkFY=;
        b=Vt2hh5hrJFF2V8FjYXDD+PorTblWz9GW2REyB6vxKzvGYA8bUBlb0ykFt7cMN2usbw
         F7sMn3FvHYOIp1pOISnBUl3Z/bkI4U6rgh3kylae9vR92Cb1W6rW6/xtNRz6Ja7A/TQq
         nBqwZCrlcup2XT0Lt0jrP6AlJowJnzmEPOz1WMesJkHbn6qgAsmrCmoBzERHWYObaT0q
         7cWEqkTpXIWKN2hc+vkVB+k0ZUD1Nhgi54TsuqHQE1uC2PKtITzv9oVKV8upeMVl/yeM
         xPYv5PMvXAvjNOEnqhTr6opyAQJ++FVSF6IE+Jf2DLOhIaJtfatg9ae4Po7R6lS+LR6P
         ETEg==
X-Gm-Message-State: AOAM531+r44KrJ7QUtnkpluphRZuioVXq7SgpQypFAmL3/7tGaLY2htS
        HeqYmV34HZUHpLz6+Q4LwhvwnVz4o3moZkXfN9k=
X-Google-Smtp-Source: ABdhPJy2z+zmcsY2f7EhYaIPh44+N9lbCSJ0WFfhs8rNUzDLIVMxQHb0x+LbLTm0kWpukVkKjbvJg3ZYShE754ZzMj4=
X-Received: by 2002:a50:9faf:0:b0:413:2c87:9b22 with SMTP id
 c44-20020a509faf000000b004132c879b22mr92208edf.346.1645662625030; Wed, 23 Feb
 2022 16:30:25 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:906:141a:0:0:0:0 with HTTP; Wed, 23 Feb 2022 16:30:24
 -0800 (PST)
Reply-To: fionahill.usa@outlook.com
From:   Fiona Hill <drivanrobert81@gmail.com>
Date:   Wed, 23 Feb 2022 16:30:24 -0800
Message-ID: <CAJp5pinj95nGdd3p4OxCb-nPhdLd=1QXnbSK8TR9MnWqdU8djg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

-- 
Please with honesty did you receive my message i sent to you?
