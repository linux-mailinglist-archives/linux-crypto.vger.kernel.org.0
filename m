Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19244417C7A
	for <lists+linux-crypto@lfdr.de>; Fri, 24 Sep 2021 22:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344835AbhIXUt7 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 24 Sep 2021 16:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245656AbhIXUt6 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 24 Sep 2021 16:49:58 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B945C06161E
        for <linux-crypto@vger.kernel.org>; Fri, 24 Sep 2021 13:48:25 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id i12so8423757ybq.9
        for <linux-crypto@vger.kernel.org>; Fri, 24 Sep 2021 13:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=0qEo5Ap0ifMWHx1F0/BPWjIUEuK4FRkMI4xfMQnIEvY=;
        b=e/Glh4PkFKsVuF7Cquv4a8Co1lwuccP3uANYH56udWWVyRB/xlT+ZSpmos4I6MZRZV
         CXlPLuE9ZBWOSo3FsiH6bGurJH6490XDXfR/SLs2wsmZJewkN4nFriUWhJRB+/ihqjM9
         CGRfkmOiV55OZfmZ+1JFMht00/vuOCXDao/w7EKyxPk26k6sv6kWLAmqWky60sF6qIfE
         6fnmGjHKWQcMKkz73RsZepjWOf+ivEda7eM9TmomZ7r+KCY3MsRf63KeArI7EmWzdO5j
         5E+8Spgl19CkArJh6nIgHZp0DsThJkYuIQsMsaUCSvtyYUtnOgdfZyoYYITbzpW0M62v
         kXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=0qEo5Ap0ifMWHx1F0/BPWjIUEuK4FRkMI4xfMQnIEvY=;
        b=fvcoskmrdtgcuhl9wPwKlMyc/PQA1pPkNXaHiTwntlnJqr6zxH5se9ww78oCCd9pbp
         P46hO8aLDraHAMK26gulECyT8i9iS3RTN1GkxUd+xzaLgTcftMVfNWBUGGvQG3ozf1ID
         WxjftAeiCdD7s7sJ0/WZYUzy9YdTX8enAMRqDnjGiDQrhCqHV9lNikAiuzrWVYbyWzHc
         arqyuWJn/YndUUe+4TossdIrsCHJAkZP5gwH7n1hKHkvz4PxkiNaD9DwW2WDaBVNSVZ4
         bA7+3/15BB551a3cnGInvtZ6KtfQdj83bVwa5WPXPodIA7k/GrgkTHbRQO25Umjzidkz
         Fs9w==
X-Gm-Message-State: AOAM531p/sCE3R/5oFvg/xPePFXzOtwxHrxWbRaMliRWLoZdOxFnHMUm
        K0IWtiEjCH19I/mjxNl4wJivjSD3A0kiZlaPhFI=
X-Google-Smtp-Source: ABdhPJwrGDS7f0inz5qJ5qjH9lS5vmNoPC9uM80lrxfeQceh+amew2tUsYuHtcVoHOjUGgaox6oX50IWoxj5XmPAhgI=
X-Received: by 2002:a25:7e81:: with SMTP id z123mr15013702ybc.64.1632516504227;
 Fri, 24 Sep 2021 13:48:24 -0700 (PDT)
MIME-Version: 1.0
Reply-To: richardmendyy@gmail.com
Sender: claraakone@gmail.com
Received: by 2002:a05:7110:6030:b0:fa:19f2:1417 with HTTP; Fri, 24 Sep 2021
 13:48:23 -0700 (PDT)
From:   Richard Mendy <richardmendyy@gmail.com>
Date:   Fri, 24 Sep 2021 20:48:23 +0000
X-Google-Sender-Auth: jfhM2kVC7emn3EmAOOdOv0bJ9I8
Message-ID: <CADRfTEBKhEv0J4Lc3T4sqHwnoHuwAuFTtzkjocQpRUwpTcDQug@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

I am Mr.Richard, i work as an accountant in a bank. I am contacting
you independently of my investigation in my bank, i discovered an
abandoned sum of $11.6million dollars, the money belongs to one of our
foreign customer who died along with his supposed next of kin since
July 22, 2003. The money has been here in our Bank lying dormant about
19years now without anybody coming for the claim of it. I need your
urgent assistance in transferring the fund into your private bank
account.

I want the bank to release the money to you as the nearest relative
and next of kin to our deceased customer. The banking laws here does
not allow such money to stay more than 21years because the money will
be recalled to the bank treasury account as unclaimed fund. That is
why contacted you for a business deal where this money can be shared
between us in the ratio of 40% for you and 60% for me by indicating
your interest i will send you the full details on how the business
will be executed.
