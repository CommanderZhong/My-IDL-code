pro v_others,start,arrive,v,han,ps=ps,png=png,bpath=bpath,epsilon=epsilon

   au=149597871l
  ; velocity & arrive time/Half angle profile
  loc=where(arrive ne '-------------------')
  arrive1=arrive(loc)
  start1=start(loc)
  v1=v(loc)
  epsilon=epsilon(loc)
  han=han(loc)
  
  coeff1=linfit(v1,han)
  npoint=101l
  vn=lindgen(npoint)*2500/(npoint-1)
  han_fit=coeff1[0]+coeff1[1]*vn
  
  arrive1=strmid(arrive1,0,4)+'/'+strmid(arrive1,5,2)+'/'+strmid(arrive1,8,2)+' '+strmid(arrive1,11,8)
  arrive2=anytim2tai(arrive1)-anytim2tai(start1)
  
  
  ;d_fit=coeff3[0]+coeff3[1]*vn
  if min(arrive2) gt 60.*60*24 then begin
    arrive2=arrive2/60./60./24
    v_other=plot(v1,arrive2,POSITION=[0.11,0.51,0.97,0.99],xrange=[100,2200],xtickformat='(A6)',ytitle='T!Ipro!N(day)')
    v_other.SYMBOL='o'
    v_other.LINESTYLE=''
    v_other.SYM_COLOR='r'
    v_other.font_size=18
    resultx=comfit(v1,arrive2,[0,6e-4],/double,/HYPERBOLIC)
    t_fit=1./(resultx[0]+resultx[1]*vn)

    v_other=plot(vn,t_fit,/curr,/overplot,'g-.')
    re=replicate(1,100)
    v_other=plot(v1,v1*arrive2*60.*60*24/au,/curr,xrange=[100,2200],xtitle='V!IGCS!N(km.s!E-1!N)',ytitle='D!Ipro!N(AU)',position=[0.11,0.11,0.97,0.49],linestyle='',symbol='+',sym_color='r')
    v_other.font_size=18
    ;print,v1(where(v1*arrive2*60.*60*24/au gt 1)),n_elements(v1(where(v1*arrive2*60.*60*24/au gt 1)))
    ;pmm,v1(where(v1*arrive2*60.*60*24/au gt 1))
    v_other=plot(indgen(100)*25,re,/curr,/overplot,'b.')
    ;v_other=plot(vn,d_fit,/curr,/overplot,'g-.')
    ;text1=text(1600,2.8,string(coeff3[1]),/data,color='green',alignment=0.5,font_size=20)
    if keyword_set(ps) then v_other.save,bpath+'result_image/v_others.eps',resolution=512,/transparent
    if keyword_set(png) then v_other.save,bpath+'result_image/v_others.png',resolution=512,/transparent
    v_other.close
  endif
  v_han=plot(v1,han,/curr,POSITION=[0.12,0.11,0.97,0.99],xtitle='V!IGCS!N(km.s!E-1!N)',ytitle='$\omega $(!Eo!N)')
  v_han.SYMBOL='x'
  v_han.LINESTYLE=''
  v_han.SYM_COLOR='r'
  v_han.font_size=20
  v_han=plot(vn,han_fit,/curr,/overplot,'b.')
  if keyword_set(ps) then v_han.save,bpath+'result_image/v_han.eps',resolution=512,/transparent
  if keyword_set(png) then v_han.save,bpath+'result_image/v_han.png',resolution=512,/transparent
  v_han.close
  
  
  
  npoint=101l
  eps0=indgen(npoint)*120./(npoint-1)
  aneps=plot(epsilon,han,position=[0.12,0.11,0.97,0.99],yrange=[10,100],xtitle='$\epsilon $(!Eo!N)',ytitle='$\omega $(!Eo!N)',font_size=20)
  aneps.symbol='D'
  aneps.linestyle=''
  aneps.sym_color='r'
  aneps=plot(eps0,eps0,/curr,/overplot,'b.')
  text0=text(80,72,'$\omega=\epsilon$',/data,color='blue',alignment=0.5,font_size=20)
  if keyword_set(ps) then aneps.save,bpath+'result_image/aneps.eps',resolution=512,/transparent
  if keyword_set(png) then aneps.save,bpath+'result_image/aneps.png',resolution=512,/transparent
  aneps.close
end