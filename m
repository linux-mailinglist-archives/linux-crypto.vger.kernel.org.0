Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34B061835EB
	for <lists+linux-crypto@lfdr.de>; Thu, 12 Mar 2020 17:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgCLQOV (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 12 Mar 2020 12:14:21 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45912 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbgCLQOV (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 12 Mar 2020 12:14:21 -0400
Received: by mail-io1-f66.google.com with SMTP id w9so6234383iob.12
        for <linux-crypto@vger.kernel.org>; Thu, 12 Mar 2020 09:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=UpxhWkpBCrzS4IiDHieZ2DOYOhwHCIm2gxPNpiXmddk=;
        b=BPdjir9+y6PnNGzPlGp6DfRGjLmSNw8TGMiZun/yIkd150wXNtk7SaZ9OTmZW15P/e
         fVMNY5zXv8nTVNiFR94yZwGcWU8m/c56vsvhrIp8OjNXMhMPiK3DsnDz3Ecprut8kQuQ
         42CX15gxofSiy+81+bslibVErv/Qv2IT4hYs5pCW8fPy9lxx01ZFUv8yWMWoI6F38+MX
         ZJ0PQrxE22wpLCxDZ820mA7chusuWqCRcYTKc758+db2xZfaltwCDwI2gqsln0eLKS/Y
         QcpoHx8l8W8PqhVhjBxjnkB141S0Kn/XrehfE5gIdVRBCPt5FemGknFI2hzXQERAArpH
         Lc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=UpxhWkpBCrzS4IiDHieZ2DOYOhwHCIm2gxPNpiXmddk=;
        b=V1oUJrfnSbYk8V6IQn6peOqqUhYFdonaJsBJWwTKQDA1oWfO2mv9uifr70Rvt16X4S
         aD+HLSqK7KorOeHVt7s+1oSp9uf6U7ecPQ4qrSX8HBnaiVxhJtT4f3eo5mY2pfej6onL
         Omix8bu2fyL3uhs5HaTfdF037DeH5TNefb79p+SU5fLjfrMeofL0CPhdSR6I3PuN5wXN
         lPo5SthKHtuaPAQSMfiQTrNX0z9vCeL3z8kzxFqdgQdZiQs5m/XZTU2Zt5GjDbO1BDxl
         u0d63prgnyRFlHjYtpGfnHijTbQUWLkWRfjzwCyQoGJJyJ14xY6hntn+8FoN/miPwmqm
         ofMQ==
X-Gm-Message-State: ANhLgQ0KHZyKRppPK2gbIxP1ozBU563m4BPJVvyJaxLxUhqAvuwoNIKf
        +/GVcd8gbdufdcESoYinOTxBNe/WF5iXz6wU4Rg=
X-Google-Smtp-Source: ADFU+vtLU+3hQMSBIDNI4CofHnylYnazr8Aj3/75W1jJkRfkW+0iRsmIrSMqVZMEO72KTo0HQEYik1pq9dEDfeEEC0c=
X-Received: by 2002:a02:7b13:: with SMTP id q19mr8537791jac.73.1584029660824;
 Thu, 12 Mar 2020 09:14:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:dd13:0:0:0:0:0 with HTTP; Thu, 12 Mar 2020 09:14:20
 -0700 (PDT)
From:   Ade Danis <barradeolachambers@gmail.com>
Date:   Thu, 12 Mar 2020 09:14:20 -0700
Message-ID: <CAOMUSba3WOYObU8=jUwmn64dYSLmh6EpEd+oBwgVGM5N8KW2Og@mail.gmail.com>
Subject: =?UTF-8?B?576O5aW955qE5LiA5aSp?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

576O5aW955qE5LiA5aSpDQoNCuaIkemcgOimgeaCqOeahOWQiOS9nOWSjOaCqOeahOeQhuino++8
jOaJjeiDveS4juaCqOS9nOS4uuWkluWbveS8meS8tOaIluS6suaImuS4gOi1t+WwhjEsNDMw5LiH
576O5YWD6L2s5YWl5oKo55qE5biQ5oi344CCIOaIkemcgOimgeaCqOeahOeri+WNs+etlOWkje+8
jOS7peS+v+aIkeWwhui1hOmHkeeahOaJgOacieivpue7huS/oeaBr+WPkemAgee7meaCqA0KDQrm
gqjnmoTpl67lgJnvvIwNCuS4ueWwvOaWr8K35aiB5bCU6YCKDQo=
