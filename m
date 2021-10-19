Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E440F433A12
	for <lists+linux-crypto@lfdr.de>; Tue, 19 Oct 2021 17:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbhJSPVS (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 19 Oct 2021 11:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbhJSPVS (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 19 Oct 2021 11:21:18 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EDAC06161C
        for <linux-crypto@vger.kernel.org>; Tue, 19 Oct 2021 08:19:05 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id q129so5534726oib.0
        for <linux-crypto@vger.kernel.org>; Tue, 19 Oct 2021 08:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=q8vQE+HmIfWkb65K2J2uXpKBOlty9aAFy9WCCtopoz0=;
        b=a5tswlXGfUUbaNrEYfG4aFWWVcD0t2HuAFP2ulgdPYMiU9RkTMkCG9UJV/P+9ANULq
         2t5PD/G/BE9VWv7uF8qD9nKGlqY4EGXQogMtVvMkw0oiK9/MnNcpy/FwPQerXplzMguK
         l7t6Sa57zlYV+ew3UkU8mTGUyhOr3WKJVvMh+zsrG7J8feB9GU2V+GDV8/7/R3R7eTDB
         4xuVEaajJ2dRgpYt4uMV/8DGSzFKduYz28JC9jAczws7OqYZHVmDLGo9yHKveATO0eGv
         mN/GWZzg8atMTO8HU5Mi8YiUh0Ff5okSm4WCFjJ3tSnxzgou5J0BODixIpZEacofOvpt
         pcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=q8vQE+HmIfWkb65K2J2uXpKBOlty9aAFy9WCCtopoz0=;
        b=XtLa0MHgmD2FL+vwVStdSCWg+9bGj0wtarZVhHZuWRMjinR8QVWAqRsMhS6XsM6Q1V
         quJg2UJXdej66DkMfG/NvG7vDh7bn++YxWD5x5bT5y5WYQ0mRJvWAA8aNbN3vo3ehRVH
         k8HBiLPUoa+1zhzD4Pq3WHucsmvvI5dVyv2eQsNgAxIpRIMlx2TCNgUagcgzxSi2h9cB
         Yjg3+hlwh6jrigxA3ZyzYeiaZobU6HqGOd7kkoKc3Ci9MTZp7R1A+lgtrNJiIkQ/1Bpk
         DeNfs3jHgnutSPo/BdjyV+iJPOQMVWvPZ3mOnmLvXbCv4ZYeppF0vNNvHvh9v8D2TSam
         s0CA==
X-Gm-Message-State: AOAM533C1QcEK46B7xxrL8++beZ/XVimNuVmUhsSb8VePG9bfX7PSc+D
        2EhcxCZJfPX2WfUVRS+feMvAwdYu95gKq8dYKcM=
X-Google-Smtp-Source: ABdhPJxK4L9HrghkuQSklOqJZ1YeKGn2DzmwIocofFGpBb//xbq7iojmjdi2X5HHxYsW1eZ9otWw+d66msGxCUIVJsM=
X-Received: by 2002:aca:b4c4:: with SMTP id d187mr4599216oif.66.1634656744458;
 Tue, 19 Oct 2021 08:19:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:37c6:0:0:0:0:0 with HTTP; Tue, 19 Oct 2021 08:19:04
 -0700 (PDT)
Reply-To: phillipknight903@gmail.com
From:   Phillip Knight <johnvivian003@gmail.com>
Date:   Tue, 19 Oct 2021 08:19:04 -0700
Message-ID: <CAObpVKu81uVsUxO2dGJiBFGJVaL-d0M=CijP=imB8GZW9tHuxQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

--=20
Lieber Freund.

Ich bin Herr .Gabriel Edgal, ich bin leitender interner Pr=C3=BCfer der
Btci-Bank, ich habe
ein aufgegebener Fonds in H=C3=B6he von 9,5 Millionen US-Dollar, der an Sie
=C3=BCberwiesen wird, was wir sind
50:50 teilen. Du wirst nur als n=C3=A4chster Verwandter zu meinem Verstorbe=
nen stehen
Kunde, der den gleichen Nachnamen tr=C3=A4gt wie Sie, der Fonds wurde in un=
serem
  Bank vor so vielen Jahren von meinem verstorbenen Kunden, der mit
seinem ganzen gestorben ist
Familie bei einem Autounfall im Jahr 2010. Ich m=C3=B6chte dich als
Ausl=C3=A4nder einladen
Partner, der dem verstorbenen Kunden als n=C3=A4chster Angeh=C3=B6riger zur
Seite steht, damit wir
wird einen Anspruch auf das eingezahlte Guthaben erheben und es
zwischen den beiden aufteilen
uns 50: 50 je . Ich m=C3=B6chte, dass Sie mir sofort antworten, um weitere
Informationen zu erhalten

Mit freundlichen Gr=C3=BC=C3=9Fen,
Herr .Gabriel Edgal
