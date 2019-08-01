--RETENIDOS

Select Distinct RETENIDOS.PEDIDO,
                To_Date(SysDate, 'dd-mm-yy') hoy,
                To_Date(SysDate, 'dd-mm-yy hh24:mi:ss') ahora,
                'Retenidos' As TIPO,
                To_Date(RETENIDOS.FECHA_SALIDA, 'dd-mm-yy') FECHA_SALIDA,
                To_Date((RETENIDOS.FECHA_SALIDA) + 1, 'dd-mm-yy') FECHA_SALIDA2,
                Case
                  When RETENIDOS.CCENTDIS = '001' Then
                   '944'
                  When RETENIDOS.CCENTDIS = '002' Then
                   '200'
                  When RETENIDOS.CCENTDIS = '004' Then
                   '940'
                  When RETENIDOS.CCENTDIS = '005' Then
                   '905'
                  When RETENIDOS.CCENTDIS = '006' Then
                   '943'
                  When RETENIDOS.CCENTDIS = '023' Then
                   '913'
                  When RETENIDOS.CCENTDIS = '024' Then
                   '914'
                  Else
                   RETENIDOS.CCENTDIS
                End ALMACEN,
                To_Char(RETENIDOS.DCPOSTAL) LOCALIDAD,
                RETENIDOS.OC,
                RETENIDOS.SUBORDEN,
                RETENIDOS.RUT,
                RETENIDOS.NOMBRE_CLIENTE,
                RETENIDOS.TELEFONO,
                RETENIDOS.REGION,
                RETENIDOS.BARRIO,
                RETENIDOS.DIRECCION,
                RETENIDOS.QTUNIDAD CANTIDAD,
                RETENIDOS.FECHA_PACTADA,
                RETENIDOS.FECHA_REPARTO,
                '1' ORDEN,
                RETENIDOS.CPROVEED As ABASTECIMIENTO,
                RETENIDOS.XMETODOE As RANGO,
                RETENIDOS.XRANGHOR As RANGO_HORARIO,
                RETENIDOS.CTIPTRAB
  From (Select F057PEDC.CTIPTRAB As TIPO_TRABAJO,
               F057F12.CCENTDIS,
               F057PEDC.XPEASGCD,
               F057PEDC.CNPEDIDO As PEDIDO,
               F057PEDC.FESALIDA As FECHA_SALIDA,
               F057F12.FPACTADA FECHA_PACTADA,
               F057F12.FREPARTO FECHA_REPARTO,
               F057PEDC.XSITSALI,
               F057PEDC.XSITANUL,
               F057PEDC.QTUNIDAD,
               F057PEDC.XCLILUEN,
               F057F12.DPROVINC,
               F057F12.CCNSGSAL,
               F057F12.CEMPRESA,
               F057F12.CTIPTRAB,
               OMS_T057F12.DCPOSTAL,
               OMS_T057F12.DOFULFILLMENTSTATUS,
               F057F12.SALESORDER_ID As OC,
               To_Char(F057F12.NDOCUMEN) As SUBORDEN,
               F057F12.DPERSONA As RUT,
               F057F12.DRAZSOCI As NOMBRE_CLIENTE,
               F057F12.DTELEFON As TELEFONO,
               F057F12.DEREGION As REGION,
               F057F12.DDBARRIO As BARRIO,
               F057F12.DDIRECCI As DIRECCION,
               F057F12.XRANGHOR,
               F057F12.XMETODOE,
               F057F12.CPROVEED
          From F057F12, F057PEDC, OMS_T057F12
         Where F057PEDC.CCENTDIS = F057F12.CCENTDIS
           And F057PEDC.CCNSGSAL = F057F12.CCNSGSAL
           And F057PEDC.CEMPRESA = F057F12.CEMPRESA
           And F057PEDC.CNPEDIDO = F057F12.CNPEDIDO
           And OMS_T057F12.DO_ID = F057PEDC.CNPEDIDO
           And (F057PEDC.XPEASGCD = 'N' And
               F057PEDC.FESALIDA Between Trunc(SysDate) - 30 And
               Trunc(SysDate) + 1 And F057PEDC.XSITSALI = 'RE' And
               F057F12.CCNSGSAL = '1' And
               OMS_T057F12.DOFULFILLMENTSTATUS = 'Released' And
               F057PEDC.CCENTDIS In
               ('001', '002', '004', '005', '006', '023', '024') And
               F057F12.CTIPDOCU = 'F12')) RETENIDOS