library(reticulate)
library(plotly)


use_python('/AppData/Local/Continuum/anaconda3/')



# create python variables --------------------------------------------------

py_run_string("print('hello slc')")



py_run_string("x = 100")
py$x 

y = py$x + 100








py_run_string("dict1 = {'A':1,'B':2}")

py$dict1
























# use python objects ------------------------------------------------------

dict1 = py_dict(keys = c('A','B','C'),  values = c(1,2,3)  )
dict1

dict1['A']
dict1$A



py_to_r(dict1)




























# use import modules ------------------------------------------------------
# conda_install('pandas','numpy')
# import pandas as pd
pd = import("pandas", convert =FALSE)
iris = pd$read_csv("iris_data.csv")
iris



description = iris$describe()
description





class(iris)

sum(iris$Sepal.Length)


(iris$Sepal.Length)$sum()
















# convert python variables to r -------------------------------------------

iris_r = py_to_r(iris)
class(iris_r)


sum(iris_r$Sepal.Length)














# call sir function ------------------------------------------------------

source_python('sir_model.py')

N = 3200000

i0 = 40/N
r0 = 0
s0 = 1 -i0 - r0


sir_df = sir_model(N, s0, i0, r0,  beta = 1.5 ,  gamma = 1/7)
head(sir_df)
class(sir_df)


ggplot()  + geom_line(data = sir_df, aes(x=t, y=S,color = 'Susceptible'))+
           geom_line(data = sir_df, aes(x=t, y=I,color = 'Infectious') ) +
           geom_line(data = sir_df, aes(x=t, y=R,color = 'Recovered') ) +
           
           scale_color_manual( ' ',values = c( 'Susceptible'='dodgerblue'
                                               , "Infectious" = 'red'
                                               , "Recovered" = 'darkgreen'
           ) ) +scale_y_continuous(labels = scales::comma)









# call seir function ------------------------------------------------------

source_python('seir_model.py')

N = 3200000

e0 = 40/N
i0 = 0
r0 = 0
s0 = 1- e0 -i0 - r0

seir_df = seir_model(N,s0,e0, i0, r0,  beta = 1.5 , delta = 1/5, gamma = 1/7)
head(seir_df)



ggplot()  + geom_line(data = seir_df, aes(x=t, y=S,color = 'Susceptible'))+
         geom_line(data = seir_df, aes(x=t, y=E,color = 'Exposed') ) +
         geom_line(data = seir_df, aes(x=t, y=I,color = 'Infectious') ) +
         geom_line(data = seir_df, aes(x=t, y=R,color = 'Recovered') ) +
         
         scale_color_manual( ' ',values = c( 'Susceptible'='dodgerblue'
                                             , "Exposed"  = 'orange'
                                             , "Infectious" = 'red'
                                             , "Recovered" = 'darkgreen'
         ) ) +scale_y_continuous(labels = scales::comma)













# call seir function ------------------------------------------------------

source_python('seirq_model.py')

N = 3200000

e0 = 40/N
i0 = 0
q0 = 0
r0 = 0
s0 = 1- e0 -i0 - r0-q0

seirq_df = seirq_model(N,s0,e0, i0, r0, q0, beta = 1.5 , delta = 1/5, gamma = 1/7, mu = .5, ep =  1/7)
head(seirq_df)



ggplot()  + geom_line(data = seirq_df, aes(x=t, y=S,color = 'Susceptible'))+
         geom_line(data = seirq_df, aes(x=t, y=E,color = 'Exposed') ) +
         geom_line(data = seirq_df, aes(x=t, y=I,color = 'Infectious') ) +
         geom_line(data = seirq_df, aes(x=t, y=R,color = 'Recovered') ) +
         geom_line(data = seirq_df, aes(x=t, y=Q,color = 'Quarantined') ) +
         
         scale_color_manual( ' ',values = c( 'Susceptible'='dodgerblue'
                                             , "Exposed"  = 'orange'
                                             , "Infectious" = 'red'
                                             , "Recovered" = 'darkgreen'
                                             , "Quarantined" = 'purple'
         ) ) +scale_y_continuous(labels = scales::comma)

