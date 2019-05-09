Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64DE4193B7
	for <lists+linux-crypto@lfdr.de>; Thu,  9 May 2019 22:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfEIUpE (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 9 May 2019 16:45:04 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37854 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfEIUpE (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 9 May 2019 16:45:04 -0400
Received: by mail-lf1-f65.google.com with SMTP id h126so2543721lfh.4
        for <linux-crypto@vger.kernel.org>; Thu, 09 May 2019 13:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SkBBPXeIB8LW8cuFnZ2MQROYlV60TjMmGBfCT+tOtok=;
        b=HI0yY/svR6KkVqH+UM6r346wXsZSI8JPRk+WfV2nqWPAPmUO62xlVGxqsnRItjYuok
         BHJRVsaK8xjibTpUXCsQwxmdzjEJ5hG8F3el2HJ1St4itGwD8519+EYd2WbUmeRx5eAR
         mTyGRZ/at0SWK+SbQKx7VDI4iuvSe3j1ed0Kh/V8oHRqfeDcB+tPJ+Zwg8Q9dlZJhuOr
         4ccvhD4AwFnTcrPQvOkc+jEgI0pK/1XtxMO91ujJQR+z778HNeSBDQ9Ne7/Yo7CWKHqP
         mWKcmQ3kka3VRKdBhSDHVgrZpfWELOlE7Qf54aen2VrGPd6U+gnJANcf1ezQxafvJ17g
         4+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SkBBPXeIB8LW8cuFnZ2MQROYlV60TjMmGBfCT+tOtok=;
        b=uDCbEgY69vGXKmsgWp4j5fobmLY/8Tl5SG7z4osQn93KH7SZsyt2usuJbvsIZ5+o+V
         MZxUrStPOb1FeIcIvmK8pnsRtOG4h66Dmp+1j5UuNAHwjiID6T/uXbLb5JfpjpboEOBx
         I4aqlxlBJHVLYMe09lG+xciLYQk+9fLnHwz2JeZtVbWOF0hy8FaSYq6h1hlm8O9ipPek
         V8rz5bMyUf5xDYSUA+RvXP7CoVrTE13dbbItMxOvDpbP+mnKDDgY7LjBsFP+Zm9WWNZQ
         Ua8fMnKYtQpSG/TMmQ16V4Iny3hnmZc6CATTzrCX9QxJS2G635dXsu6LuTMXqMKxYST/
         ha/g==
X-Gm-Message-State: APjAAAW9TjIgjCbGypPr8qfJu4CZ5CQSaYor8HVyhMHdf4Ral97UL4sq
        ajPlhbJza4n5wpOooSJ0H51TDNQi4Z9e6huOLtPeqA==
X-Google-Smtp-Source: APXvYqwJ89daYgRA/3X/6OD+ICirWwVWtRBr/yc//fC2OgaJJdviuvByTSwRjP68U1zu32Rbexi14IilIIrOE78Pac8=
X-Received: by 2002:a19:f243:: with SMTP id d3mr3494821lfk.168.1557434702732;
 Thu, 09 May 2019 13:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190430162910.16771-1-ard.biesheuvel@linaro.org> <20190430162910.16771-6-ard.biesheuvel@linaro.org>
In-Reply-To: <20190430162910.16771-6-ard.biesheuvel@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 9 May 2019 22:44:51 +0200
Message-ID: <CACRpkdYGzOCAecgG=MkFRJyVEK9sfSXHq7g959TzDvXNWqA-Ug@mail.gmail.com>
Subject: Re: [PATCH 5/5] dt-bindings: add Atmel SHA204A I2C crypto processor
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-crypto@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Joakim Bech <joakim.bech@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Apr 30, 2019 at 6:29 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:

> Add a compatible string for the Atmel SHA204A I2C crypto processor.
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
