Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 572BD193B5
	for <lists+linux-crypto@lfdr.de>; Thu,  9 May 2019 22:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfEIUoO (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 9 May 2019 16:44:14 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44404 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfEIUoN (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 9 May 2019 16:44:13 -0400
Received: by mail-lj1-f193.google.com with SMTP id e13so3175123ljl.11
        for <linux-crypto@vger.kernel.org>; Thu, 09 May 2019 13:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lvtUJJb0iNqVdb4vPqW3DNLHuDDNoFxuTr9vcZlmfYE=;
        b=VzIrI3ecqwSM6jYZXCRsiUQ0Xos5N3/XKDHR1L6BP8D5KTKSTCIfTLD7sTzJkVx24J
         ROqzT0XU3prbYFbFjoateKWuP+jfKR+uAy04H/Y2WWDmAqbopNoZ+tr75j5yj8m4d64x
         O3Y0srfxkF9qu31TW9DyDUuC5NVqbaKBYvXq9yHOvER52jrsureK5UTYUrnR6c1fMq3R
         m+XQtja9jpp3j1wruPc3exF8F71rZyZIyjp50Er/6LLRkmb5qeH+tVhC4kiO5mPVjx/5
         OjAjjGcTZH/UjLpGFXoAQsHbR6cdo1W/PN4GaDmdxWoROCBlCprbbbaDE8aGIXpjhnHY
         sRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lvtUJJb0iNqVdb4vPqW3DNLHuDDNoFxuTr9vcZlmfYE=;
        b=V1vs5qQVFViZdE81Who8iH8DIlsyEmDQ5D2Az7CHJGjqhoHzkKSCH1o75sC6j86WBZ
         DNP3iTksjvaTI/E+RBv7hzwrAn4yL3xBTiIR0G4OtZOV1/Xuf7725MMvOKjexfFbPSHZ
         qDnAdX5zdZyY/m2XYRpOAufgI2Ige8ZU2HQYOpNXx6bFe3iEScISvY+LVcLgLgf4fgh4
         8Ay7VbWEi5I6bmicPDPRV5ud8jukXsretIYwPBbia0mBKmsalqVT19Jpf/fxrpy+UtEY
         fb7jvsSSTkThBKMqErW4EYrwG47qsfVYNz6XYmws7Rv12m2sbgO1rjDaiS6uOYt/1nbp
         roaA==
X-Gm-Message-State: APjAAAWMnBpmHfHg6v1J7uNXzW4HLxIEWwvd5As4Tl+oQ+UKhpal9Nrm
        WV+Ti7YNs9bDFwKNlyWs2r3sM9+1iLr5gvn3J9ROvg==
X-Google-Smtp-Source: APXvYqzwi4uZhDCkP2BfeENRzYZP+A4m0hw6TsqWt4GdvE2cwYop/OrA9K5YyynmpUzYgSR37wY0ao+egjoI7YKk4d0=
X-Received: by 2002:a2e:3a17:: with SMTP id h23mr3783292lja.105.1557434651785;
 Thu, 09 May 2019 13:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190430162910.16771-1-ard.biesheuvel@linaro.org> <20190430162910.16771-5-ard.biesheuvel@linaro.org>
In-Reply-To: <20190430162910.16771-5-ard.biesheuvel@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 9 May 2019 22:44:00 +0200
Message-ID: <CACRpkdZ6sbFZ+POiC3eFSi1__SkGLjbWdT-ghMtXds-Xo4GPig@mail.gmail.com>
Subject: Re: [PATCH 4/5] crypto: atmel-i2c: add support for SHA204A random
 number generator
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-crypto@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Joakim Bech <joakim.bech@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Apr 30, 2019 at 6:29 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:

> The Linaro/96boards Secure96 mezzanine contains (among other things)
> an Atmel SHA204A symmetric crypto processor. This chip implements a
> number of different functionalities, but one that is highly useful
> for many different 96boards platforms is the random number generator.
>
> So let's implement a driver for the SHA204A, and for the time being,
> implement support for the random number generator only.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
