Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82CCE2AEAAF
	for <lists+linux-crypto@lfdr.de>; Wed, 11 Nov 2020 08:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgKKH6M (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 11 Nov 2020 02:58:12 -0500
Received: from sonic310-13.consmr.mail.bf2.yahoo.com ([74.6.135.123]:44244
        "EHLO sonic310-13.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726245AbgKKH6I (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 11 Nov 2020 02:58:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1605081486; bh=WUESKagEm1rdmKBSWVtDCW1cpdCKHA0ui3YTmWJbjYQ=; h=Date:From:Reply-To:Subject:References:From:Subject; b=pou92OyjzsUBcSsvOYs+gw4CSAmk6NR/XO2Xa8HTuFLF6Sr+1f5OAeGmZTNgNmWCtH/z30aWK5l+5Npb0KE5hVIsPr7S68t+hK6PXRuPLlfrBO7JQx2i663ODEPSytbWz1FL67wW3l6TJemfORwxYGi6I6S0gqjtjRqpDPzWaeDXnoUuEUg1y4mgBtxNyvrEDQdPUfQ11oWGn/3pFYuGLaAYgxccTatO7PIsrqwEUh4eyxIvXA52NoeHc0/ir4T/LMRCVaeJJnS4iLZ7EyIpNZpHie4XtvBqdDkIDJ4pVEwQw9gluv7WNcbLqaQV+wKlnkJpVAuKztg5yIl0Sa7O1g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1605081486; bh=vKL2t8+nzHueX6lHHRLwTZzgf8hetsJ+mbujcgOQu+/=; h=Date:From:Subject:From:Subject; b=pjlyaWwb6QiwhGYVRjjfrVZDvDCWP/Eq+m921s+8GYfbCdDjVhbCU/6o/5xJTf5HyaZScsirKusx3DJMJrSYGRDheLTurr1T1RQFQNRlVmj/Hy154ufCDaya+yl2vnKDgEJJfMcGgGFxQvUIYCMN4sitL1FUth18j6zB+Bx2YhEpWjIex636j3m/fOnYJ1QFaJDqUShaCk9qzvaX/RyjtZNt10aR0rEQlrliELp/g2z1DiDaE+kJREwFic1cutIuGFvFMMkaGMPQfoo1FC0Mmmwrvs6NBwkeTVe/rDtPwPv0CTYL7DIHSgaWvCoFeUtI98opHxDaulBzGkdUd2/pVw==
X-YMail-OSG: wR3OPIgVM1k.A70HuLvAhTQ4Riwdgdbr3KtbwTF6BccqmOOAtMDF.SGBmyeRyLA
 uPAY4KWIuT6wVH13sYkgq6tIfYDn2VqC2bLW0KN45SC5oJ4cKl2974q0BjvV_FY6RulyRh6JoO68
 jMtRZZaF98RUhFo0i0YRWZKXGIcj7vHs5Tb30jj6w2j3zRPEzUsMxiotRXrix.TfUzmCPci6zWen
 ODOIvEw3m1tnwtp6aEtVo4Y7Vh05TzOSqXtv2yomkgLRO43wTji02CI3c8HIcoZRubFTdeQN3SWp
 PXqTBUG0sRUsKD6.VwzYYiFofFx2ma50USS3oKyEYlNZfZ7fgRWt0IvpS.lytT3pxZMPegqDg02f
 eWo7qkGMXoUusuI48agIsyDRYbqGhY.jmxDi5cy4Hp4wHmpeaOwVLpsKTS290G8HvMUiQPaIYKN3
 E18ZjJqO5QXotTMD5gKw6lPeB9oYejUPurUtvGmzelvdVpjoc.fO3j5RxIJXQ5mTBbpkCU96uY2C
 WHpP73x4CiJtVLWsxD35H9QDbWP9lN5utB6KJBUrzv9oq5UDkwuzWztIlmTn.t8z5PMfHRk9N3QZ
 ADiQEPUEIs8Yox8jdQ3j3cnBgKkLumsqyjr95ERCeeOHrELouQsOsgB.9iLNtoi.BvwUK9jtSj8e
 LcFH0p0eXVjLHbyQ7rQKdFjxjYzk7Ilj91WkdYLfjHeo64xeGEq.Pn3Uuk_CnxP7RgozhaauxCrR
 X9sA7LSq8L1QROEPz5EFOEptOHDuLsUiiC.FbpNQuZw16qxCPOqj5Z_VYtziWaXaWU0vCoTStr8Y
 0JajvuvmdtKsNO9EO_ItLTMqSJmP9ATRYvgCAKNvJs2WCqEYPUFVqPq4_6AWBUoZ2seXV49cUINs
 CgSgGXrCZ6wU25DmzPJj9cMkOyQRZ6t1rulIovQscBhzHZLEThvBPueaA2Cy9gtPQkOusb7JGsgI
 _nJY4rP88YXbQ5i3N6QAssulZ5fDjpDLdICM6PymdhzRMkpHpUUTXqE8bd3ONQR09P.s_0ZM7Km5
 mGSBSq_KGhNjUvo8fgFv.iiWUy2DMRa5hWoA44JIcu4YukXmLUEp9RIjj6olg9JMUOXpZ9A1a.ja
 AC49MxtjhxWTzyLj.NVf7Vb7CZ.768i_cFz8QXCDtwh2Uc1YZlbRpQ5ATd5dnDiAMCSqV0GjDs4O
 yR0cHslbInhVC8AT1NwN_F5r8zFMrUk5u8ZzesW7d5pOmF6DoGYPFfp1S4Ftx6jao2VwhkkKidPm
 y_8B1Xs93LQsaHn4WkKkuIW0NSNrWZYuH2di6FHDdI2Vn_ArbQJSGMZESESQ2DV3qXtQxgBKTIEM
 GlVo2gpkl4b6yWLnCGe0VHbWRhMBm.AL8zr0T_pfshVX2tkiIzXhCKbk.VPh6QBFTbOa9UHR6yvz
 N.pCTJK0Q0Cjf0E.A2Spk2P2Trs0hbnsoLBZxxlInOiewdMbtwmzHQucTIRKK6QHrg70X8SBZgLN
 AjO_cUe9YBZCUTwSBKxH0bchMugyzT7r_c7vY0lIId8A.9XkQcuSVrsDFEQvOeYiygOgbanTh2r7
 uZPyy5vdt9k4LmAq1ma83p3ySlk2FYK3zDcCKfy0MbtKuwdPCbtUHO7WlzwJnBdDWwFI9jSlfXTb
 23CUoTOy0iTSnA2MHsypwBF5G81LmM9NLsTorpnlbbRo.w9ahBl0JR5zDBzyrjYKqt2nlezKd5Vw
 xmGRz6jr2hq4.TwZE6nRFFY8rsrh9.s0NPShKFcXm48AGIF0LMWPArFydty3rLH.YGMiFFfiFdvG
 oA9KzXZVz7e0bROffTBQSns2Mcjlde6q_8AARlNVnbtodhZNEfO091X7fftrlWtPgleEYejeLZiu
 ItQY8byGxd0BYBM4p5g47yaPYMaewhEEbjsCyG3CQW1ihT3G2gQIjmtv46wZfdU12ReF8DXyEtQf
 LzM6FUKSRqmmgifbhQ8lin5S3JpnRpFqvFDNy2JFBBmK9g7aMqFZmMz8Wpp8LHiX_jF.CSwYNii7
 LhQ.xh_rdeQaFeyfKSrkn0UAuRz11k5_eRpSAUqhjTlwBUTntwU_IuXiIJqNPZo6inNkKGjfv02T
 5kxqcG3H_fi6WfYz2a5UD8zv4DZ3Dp4WEDgoZ6uYOFqRBXHhieDBrS.wBN56miybJAzD7DzrzzNv
 Ka38JQtykh9RZMhVuQZ6066fYmErUcE.yL6uJmsj.YYndXqBwzWdoFYGpUSea8x18gkIyvvFPGh9
 eSJcxDqSmgdklhMwQwpXGgT0R.OReVdU70bpXCaQVcSIr1vCtt6yJdUqGEJGpX.2MA6JV7T8s842
 g6pdznkveqceMGdNn3DPO6Z0JuhL8wA2LvgZPnk.mBkXaW0xJwUHEixGk3fyhIMlbjPdlOiYROiQ
 MgFjdo51x5GTd.1k1Okt3QU1Ku9gpW.7hfbyQTxD4pf.BWC4rzp_cX7asAFSjY8E9NY6KZX89sse
 QnvO.qsO2Ppww7DE3QSt1XYRmV7Bfv28hTDCeRFEUHH742CKTUAoW7lqclAP3KwvFrr7D_7DkMyQ
 cpQUWxCi8wLRRkh28FL8tdYvSj_hXyeRlMQIghF1JTpGFTkSoGs6sLZ295c2lDbpeCRC9zCsbFl6
 eg134vtHif6.hTnRzfAYH3Hbt05cGeQ7bHClNlOGZf1T0zQ.GJ_LeTS.lYm5QiTmHrdvgGZwn7F.
 osCJi0QDhOC_NTdRhiLrHAp90ziI7CCkm.OGyl0XvHEVVVHb6ZIAGMTLQqugNXezT.DW.WPob774
 JzL3gsbLlJ5guKS0apKDXdFz3yt4qhoSE1y.sofcONU1louqmefR3Ga0L1SGZeyFvzWmuwiXPtxi
 C4D_4NSIzfFec17mFTF_93m4WviRpKWZFFha4k1vtG6ZFGf1YVutBECCaN93dxluTXm_RZf0DSKc
 GgZqQvZFDK4.ZFplEpaRyOKbRT_55eKyMoktzmqb6PzVtPnNUjQpZo.qOMh0JWiYgAFLrOlvF7e9
 Sj5vDL_DpQDo7h7aZl7jmeW9B_nIFix12U1Nd68jeCtRAc2Bp1Sb_C63zcaQj2CF8BvCTVQT6YaH
 djQCPgIM9WqlepKFXPs0Y87x_Hxdj50jdVFb9y1AjE4.ptZhk9kS_iEXhYGKnvRbOOe1fftxQNN.
 V1B2XOfO_s0RfJQaJmGIghjE2ZWLHDLE6I4S7OIKJWgspX1imIO1y6qoTiWJOKM0niAaqFgpYxBt
 8Ks3cyvKhM12p3g6bdatrDoWu3KUPm.xhuGOgiDjjsc9fQpUTYxsldhGHL_lAFs5EeVy580CeSme
 ElDxpu61IjSMT49NU0fYJgaEtYlMKYD8vkEEIjobX15qYD36SJQCiONH.gh3gKzxWLU4VfTSxx4Y
 qBMTnsPpUp64F1Tpa2w_NNKusVSn.IVe96VDofwFr91DzFqf8Pi8gGspf1K6G1DblUVJFDktFeY3
 Bc9Q5uYh.RrB1lQP6RvMshGvwtAi1U2EQtuOfMxxzbfFIXzdhsa4khFXSy_SjD9cdnVDnC1GaB2g
 hFsBb8qxNmTZ2ltZGTOjn.JL.rKCPEB3AtFmkxrNXbuPxXnByIGwvKPUX3DIFWS10ZyLQVhG7ZiR
 8P1BP5Mhv8GDMCaRxxR6Enxn7Pbxu7DUnUBgCATqq7XYubAwvEM9WKQybgszClUJ7Rw5AQOKnX4N
 ng5Uy6STNgCsi8k2YvwbfdBHCq7fTN1iRM_wmpWQBeC88636mo4HsQCm7Hcw0ujS4SSlNuglsGVH
 2k6bz2E5E2HzBQ3kyfwKRbTeNIVcTPoQ6Qs_7NH9SvBcCa0zKJjXW5f4RrGvcedvhlvUTmdnscvj
 eGKbXAzQmZyDxo4.4bDFoTFU_o_QcMHar06wx8HJUBOcWiHHbjLAaxCju4gLD_nHdLBZlZldGpms
 a39MQCmz0NlblPnstfqV5hunSeOyzZl2yFENKWZm.zxMMZk7AKdsZiMbaJNefS7TmeziyyOa_ecn
 pZHygR_4NU1qbjN3kuWJjIryLc_1nc6T979hSJMfl_WY2.P4Qi2z8TwoimMQS6kIVZ7yD4kgxadw
 DN8WrR.sk1TF6mAvkNLrLFXFcTnSlMv6mn2pfevvw4M9V7dzhS5tX7qFIXtW6VNN7V_wY2rEKfbd
 7ZFlVnOjIieDo7zRGDw15EOafzuW3IpBVThXg1WJC7DLSBoH3MkSxyrBpst9gDSVY8kyqTOqN9hy
 3evGTr4a5vShMzSYqxb9BhKJaHb0UWzlywu8IrhBKGQRIXyEXbOP2JMNp7wBPO6cboOpQjRnbUwz
 O2SSjt9vSoqNhoeCkoiuUEtC.EqhiHG5NKI6AgVw0ql0xWTfL4Oaji_HxH.CFfktqGsrnrDmvGJ2
 kRbUzQUzXMn.MVkxeT4cYC.3a17XRqPc6wDttBCqYwat3xwTZeaO_5xJVsnJ6tKDD7604y5ogpPd
 LlF.JV1_EToa4.x1OxzIAKVOToR9dEthNdosE5TAu.J1SALAm9rS4_3mxSHjf8EGjVNLOrr4hjHN
 o7hsBegG7YHivijjjgbuQs.JhQG5lQzCHgtaDq1scB1FzYsrV2l3EHXWbxN_VZ0E20Gp8eV7RmBL
 JiN1gVI1XYIuyMMnujuQBmgmj8_ucuJX524UzluHP843htv1e8RClYlAfCZlWeJjwN_lrRuKHZ_l
 H7gcwlgRr_Nfjr4TfAaFwTrHYprk12rfD7_uauzMW5v48Pxbe8mm7_6BZqqCBYWrg.cINMsQMFFT
 cGnxOr6aw1q.vhSjh6Iv3kDte9JsL1T2s2pEjDPMBtb_.HniOixEgVqrkjQ1D8X88NqDhb1xf0lh
 rdSov_8DL7oQggChUIGAw9r6bNg8U0nyYBOcaaCf.MYxBymruL37Pfgkrha9REaGIahY5cEUUegw
 BqFyHws7v8aL5ijjouaLo5o0k.BkEALBUCkmtoIWXAxAKoiuEZrdN_slEgrlPvG3RvBOHC0ZRom4
 9nIOj6i7_rZBxQAvr9pVYjyLK6Z7t3DcpERNpoSCfDcXQDOV3hKqWvZyWEiZLRvwTB_n7Mft9ovm
 LHbWEIM.o2woZumzrCpVbClPzzb.g2IZwWbVA56.Og6Vu48IYPCEzAo0a9LxtxPf1nPzHMPdrPrT
 jvojP0yAfw1HZeY1EkFNISpAM5p6_BqXvJFTXL56qWDzkUsLOdwDh37OYoqSFez8LRQS6ya5NhAl
 3DQ1YHHOQsHetlXIJ60fs7GtR0EM8QISONAh2faFC4ybLo236FzEjQC0ihdX_JWWEzOchBBk80Bq
 wWZT6T4Jn413edxosK0n9KgjXUGaK.IgPaYO9l.P5zwoIOdxt1KOeATcaFE62Ky8VFtMSbEdcJFi
 QaGgXTEG1TpvUKChiXGF7YoLxHUpq3SzDNn0c14VjiItUf6nSEyMCutdVP5WpYVv1OI_sf4DVU2O
 LwG5eRYikMfdmW12beuwDUNPpS71y98PhwvujHdWoC7D0kv9ekN0o4Q6Z66fNSD8Ud5mOSZskgLk
 vNbzNihxRLvra6.wpwt95y7lTeEPS0t1MyppeZ8yAWL1NMPQrtS3xrLFLTonhxA6ghYfeugP_cLW
 OMtTqNb6l_JTwa_TA2N7RkIuVpD5SQcuZ0Win18xYxu11OkaoVf0sRbwD6XCBukOULYrebDbfRHO
 G.tBE5bc1AjqNbKXz3Vpxumnj8H.aJ60rrOlWGZQXnqCVCWtkpJOzLAL9CfqpghLsoS6.vpmut_0
 vBdlN4qT0LnbfJ4tIO2L6KpI3z8WGUFtUL_9WAuzG0WbS69DAEnvorAZ47RjPSjv0hMY_O3aup.N
 KsA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Wed, 11 Nov 2020 07:58:06 +0000
Date:   Wed, 11 Nov 2020 07:58:05 +0000 (UTC)
From:   Aisha Al-Qaddafi <gaddafiayesha532@gmail.com>
Reply-To: gaddafiayesha532@gmail.com
Message-ID: <1131042862.2539126.1605081485531@mail.yahoo.com>
Subject: Dear I Need An Investment Partner
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1131042862.2539126.1605081485531.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16944 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:81.0) Gecko/20100101 Firefox/81.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Dear I Need An Investment Partner

Assalamu Alaikum Wa Rahmatullahi Wa Barakatuh

Dear Friend,

I came across your email contact prior to a private search while in need  of your assistance. I am Aisha Al-Qaddafi, the only biological Daughter of  Former President of Libya Col. Muammar Al-Qaddafi. Am a single Mother and a Widow with three Children.

I have investment funds worth Twenty Seven Million Five Hundred Thousand United State Dollar ($27.500.000.00 ) and i need a trusted investment Manager/Partner because of my current refugee status, however, I am interested in you for investment project assistance in your country, may be from there, we can build business relationship in the nearest future.

I am willing to negotiate an investment/business profit sharing ratio with you based on the future investment earning profits. If you are willing to handle this project on my behalf kindly reply urgently to enable me to provide you more information about the investment funds.

Your Urgent Reply Will Be Appreciated

Best Regards
Mrs Aisha Al-Qaddafi
